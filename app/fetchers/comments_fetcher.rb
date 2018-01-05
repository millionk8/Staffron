class CommentsFetcher < BaseFetcher

  def initialize(entities, params)
    modules = {
      polymorphic: true,
    }

    super(entities, params, modules)
  end

end