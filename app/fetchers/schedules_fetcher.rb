class SchedulesFetcher < BaseFetcher

  def initialize(entities, params)
    modules = {}

    where = []
    if params[:user_id]
      where = [['user_id = :user_id', user_id: params[:user_id]]]
    end

    super(entities, params, modules, nil, nil, where)
  end

end