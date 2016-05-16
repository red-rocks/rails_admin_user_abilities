module RailsAdmin
  module Config
    module Actions
      class UserAbilities < Base
        RailsAdmin::Config::Actions.register(self)

        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          false
        end

        # Is the action on an object scope (Example: /admin/team/1/edit)
        register_instance_option :member? do
          true
        end

        register_instance_option :route_fragment do
          'user_abilities'
        end

        register_instance_option :controller do
          Proc.new do |klass|
            @config = ::RailsAdminUserAbilities::Configuration.new @abstract_model

            if params['id'].present?
              if request.get?
                @user_abilities = ::Ability.new(@object)
                @models = RailsAdmin::Config.visible_models({})
                @excluded_actions = ["dashboard"]
                @action_aliases = {
                  show: :read
                }
                render action: @action.template_name

              elsif request.post?
                ability = @object.ability || RailsAdminUserAbilities::UserAbility.new(rails_admin_user_abilitable: @object)
                params[:user_abilities].each do |a|
                  _model = a.keys.first.camelcase
                  _model_rules = ability.abilities[_model] || {}
                  _model_rules.merge!(a.values.first)
                  ability.abilities[_model] = _model_rules
                end
                if ability.save
                  @_class = "success"
                  @message = "Успешно!"
                else
                  @_class = "error"
                  @message = "Нихера!"
                end
                render action: @action.template_name, layout: false

              end
            end
          end
        end

        register_instance_option :link_icon do
          'icon-tasks'
        end

        register_instance_option :http_methods do
          [:get, :post]
        end
      end
    end
  end
end

module RailsAdmin
  module Config
    module Actions
      class ModelAccesses < Base
        RailsAdmin::Config::Actions.register(self)

        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          false
        end

        # Is the action on an object scope (Example: /admin/team/1/edit)
        register_instance_option :member? do
          true
        end

        register_instance_option :route_fragment do
          'model_accesses'
        end

        register_instance_option :controller do
          Proc.new do |klass|
            @config = ::RailsAdminUserAbilities::Configuration.new @abstract_model

            if params['id'].present?
              if request.get?
                @users = ::User.for_rails_admin.all.to_a || []
                @excluded_actions = ["dashboard", "index", "history_index", "model_comments"]
                @action_aliases = {
                  show: :read
                }
                render action: @action.template_name

              elsif request.post? and params[:user_id].present?
                @user = ::User.for_rails_admin.where(id: params[:user_id]).first
                obj_id = @object.id.to_s
                unless @user.nil?
                  ability = @user.ability || RailsAdminUserAbilities::UserAbility.new(rails_admin_user_abilitable: @user)
                  params[:model_accesses].each do |a|
                    next if a.keys.first != @user.id.to_s
                    a = a.values.first
                    _model = a.keys.first.camelcase
                    _model_rules = ability.accesses[_model] || {}
                    _object_rules = _model_rules[obj_id] || {}
                    _object_rules.merge!(a.values.first)
                    _model_rules[obj_id] ||= {}
                    _model_rules[obj_id].merge!(a.values.first)
                    ability.accesses[_model] = _model_rules
                  end
                end
                if ability and ability.save
                  @_class = "success"
                  @message = "Успешно!"
                else
                  @_class = "error"
                  @message = "Нихера!"
                end
                render action: @action.template_name, layout: false
              end
            end
          end
        end

        register_instance_option :link_icon do
          'icon-user'
        end

        register_instance_option :http_methods do
          [:get, :post]
        end
      end
    end
  end
end
