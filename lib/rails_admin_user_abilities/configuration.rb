module RailsAdminUserAbilities
  class Configuration
    def initialize(abstract_model)
      @abstract_model = abstract_model
    end

    def options
      # @options ||= {
      #     fields: [{}],
      #     thumbnail_fields: [:image, :cover],
      #     label_methods: [:name, :label],
      #     hint_fields: [],
      #     thumbnail_size: :thumb,
      #     thumbnail_gem: :paperclip,
      # }.merge(config || {})
      @options ||= {}
    end

    protected
    def config
      ::RailsAdmin::Config.model(@abstract_model.model).user_abilities || {}
    end
  end
end
