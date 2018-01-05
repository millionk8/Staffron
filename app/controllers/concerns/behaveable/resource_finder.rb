module Behaveable
  module ResourceFinder
    def behaveable
      klass, param = behaveable_class
      klass.find(params[param.to_sym]) if klass
    end
    private

    def behaveable_class
      params.each do |name|
        if name =~ /(.+)_id$/
          model = name.match(%r{([^\/.])_id$})
          return model[1].classify.constantize, name
        end
      end
      nil
    end
  end
end