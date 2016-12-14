module RailsAdminUserAbilities
  module Models
    module Mongoid
      module UserAbility
        extend ActiveSupport::Concern
        included do
          include ::Mongoid::Document
          include ::Mongoid::Timestamps::Short
          # include ::Mongoid::Userstamp

          belongs_to :rails_admin_user_abilitable, polymorphic: true, optional: true

          store_in collection: "rails_admin_user_abilities"

          field :enabled, type: ::Mongoid::VERSION.to_i < 4 ? Boolean : ::Mongoid::Boolean, default: true
          scope :enabled, -> { where(enabled: true) }

          field :abilities, type: Hash, default: {}
          field :accesses,  type: Hash, default: {}
        end
      end
    end
  end
end
