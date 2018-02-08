class LogsFetcher < BaseFetcher

  def initialize(entities, params)
    modules = {
      ordering: true,
      pagination: true
    }

    where = []

    if params[:action_filter]
      where = [['action IN (:actions)', actions: params[:action_filter]]]
    end

    if params[:author_filter]
      where = [['author_id = :authors', authors: params[:author_filter]]]
    end

    super(entities, params, modules, nil, nil, where)
  end

end