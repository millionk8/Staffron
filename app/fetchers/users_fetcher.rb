class UsersFetcher < BaseFetcher

  def initialize(entities, params)
    modules = {
      scope: true
    }

    super(entities, params, modules)
  end

end