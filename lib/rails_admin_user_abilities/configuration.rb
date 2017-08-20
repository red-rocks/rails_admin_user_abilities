module RailsAdminUserAbilities
  class Configuration
    def initialize(abstract_model)
      @abstract_model = abstract_model
    end

    def options
      @options ||= {}
    end

    protected
    def config
      ::RailsAdmin::Config.model(@abstract_model.model).user_abilities || {}
    end
  end
end
