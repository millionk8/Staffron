class PtosFetcher < BaseFetcher

  def initialize(entities, params)
    modules = {}

    where = []
    if params[:year]
      where = [['extract(year from starts_at) = :year OR extract(year from ends_at) = :year', year: params[:year]]]
    end

    super(entities, params, modules, nil, nil, where)
  end

end