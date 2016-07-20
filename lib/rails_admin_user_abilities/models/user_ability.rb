module RailsAdminUserAbilities
  module Models
    module UserAbility
      extend ActiveSupport::Concern
      include RailsAdminUserAbilities.orm_specific('UserAbility')

      included do

        def to_cancancan(ability_object)
          abilities.each_pair do |model_name, rules|
            if Kernel.const_defined?(model_name)
              _model = model_name.constantize
              rules.each_pair do |act, meth|
                ability_object.send(meth, act.to_sym, _model)
              end
            end
          end

          accesses.each_pair do |model_name, ids_rules|
            if Kernel.const_defined?(model_name)
              _model = model_name.constantize
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
end
