class RolesFetcher < BaseFetcher

  def initialize(entities, params)
    modules = {
      scope: true,
      sti: true,
    }

    super(entities, params, modules)
  end

end