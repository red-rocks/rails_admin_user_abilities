module RailsAdminUserAbilities
  module Models
    module UserAbility
      extend ActiveSupport::Concern
      include RailsAdminUserAbilities.orm_specific('UserAbility')

      included do

        def to_cancancan(ability_object)
          abilities.each_pair do |model_name, rules|
            _model = model_name.constantize if defined?(model_name)
            rules.each_pair do |act, meth|
              ability_object.send(meth, act.to_sym, _model)
            end
          end

          accesses.each_pair do |model_name, ids_rules|
            _model = model_name.constantize if defined?(model_name)
            ids_rules.each_pair do |obj_id, rules|
              rules.each_pair do |act, meth|
                ability_object.send(meth, act.to_sym, _model, {id: BSON::ObjectId.from_string(obj_id)})
              end
            end
          end
        end

      end

    end
  end
end
