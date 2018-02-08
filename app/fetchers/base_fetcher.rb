class BaseFetcher
  attr_accessor :entities, :meta

  # Available modules:
  # - scope
  # - ordering
  # - pagination
  # - ids
  # - sti
  # - polymorphic

  # Available custom options:
  # - scope
  # - joins
  # - where
  def initialize(entities, params, modules, scope = nil, joins = nil, where = nil)
    @entities = entities
    @base_class = entities.klass
    @params = params
    @modules = modules

    # Custom
    @scope = scope
    @joins = joins
    @where = where

    @meta = {}
  end

  def fetch

    query_custom_options
    query_options_from_params

    return @entities, @meta
  end

  private

  def query_custom_options
    # Joins
    @entities = @entities.joins(@joins) if @joins

    # Scope
    if @scope
      @entities = @entities.send(@scope.to_sym) if @entities.respond_to?(@scope.to_sym)
    end

    # Where
    if @where && @where.size > 0
      @where.each do |where_array|
        clause = where_array[0]
        params = where_array[1]
        @entities = @entities.where(clause, params)
      end
    end
  end

  def query_options_from_params
    # Scope
    if @modules[:scope]
      param = @modules[:scope] === true ? :scope : @modules[:scope].to_sym
      value = @params[param]

      @entities = @entities.send(value) if value && @entities.respond_to?(value)
    end

    # Ids
    if @modules[:ids]
      param = @modules[:ids] === true ? :ids : @modules[:ids].to_sym
      value = @params[param]

      @entities = @entities.where(id: value) if value
    end

    # STI
    if @modules[:sti]
      param = @modules[:sti] === true ? :type : @modules[:sti].to_sym
      value = @params[param]

      @entities = @entities.where(type: value) if value
    end

    # Polymorphic
    if @modules[:polymorphic]
      polymorphic_name = @modules[:polymorphic]
      id_param = "#{polymorphic_name}_id"
      type_param = "#{polymorphic_name}_type"
      id_value = @params[id_value]
      type_value = @params[type_value]

      @entities = @entities.where({ "#{id_param}" => id_value, "#{type_param}" => type_value }) if id_value && type_value
    end

    # Ordering
    if @modules[:ordering]
      if @modules[:ordering] === true
        sort_field_param = :sort_field
        sort_order_param = :sort_order
      else
        sort_field_param = @modules[:ordering][:sort_field]
        sort_order_param = @modules[:ordering][:sort_order]
      end

      sort_field_value = @params[sort_field_param]
      sort_order_value = @params[sort_order_param]

      @entities = @entities.order("#{sort_field_value} #{(sort_order_value == 'descend' || sort_order_value == 'desc' || sort_order_value == 'descending') ? 'DESC' : 'ASC'}") if sort_field_value && @base_class.attribute_names.include?(sort_field_value)
    end

    # Total
    @meta = @meta.merge({ total: @entities.count })

    # Pagination
    if @modules[:pagination]

      if @modules[:pagination] === true
        page_param = :page
        per_page_param = :per_page
      else
        page_param = @modules[:pagination][:page]
        per_page_param = @modules[:pagination][:per_page]
      end

      page_value = @params[page_param]
      per_page_value = @params[per_page_param] || 10

      @entities = @entities.paginate(page: page_value, per_page: per_page_value) if page_value
    end
  end

end