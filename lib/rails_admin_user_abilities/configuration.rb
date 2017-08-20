module RailsAdminUserAbilities
  class Configuration
    def initialize(abstract_model)
      @abstract_model = abstract_model
    end

    def options
      @options ||= {
        dangerous_actions: {
          :all => ['model_accesses', 'user_abilities', 'delete']
        }.merge((config || {})[:dangerous_actions] || {})
      }
    end

    protected
    def config
      ::RailsAdmin::Config.model(@abstract_model.model).user_abilities || {}
    end
  end
end

module RailsAdminModelAccesses
  class Configuration
    def initialize(abstract_model)
      @abstract_model = abstract_model
    end

    def options
      @options ||= {
        dangerous_actions: ['model_accesses', 'user_abilities', 'delete']
      }.merge(config || {})
    end

    protected
    def config
      ::RailsAdmin::Config.model(@abstract_model.model).model_accesses || {}
    end
  end
end
