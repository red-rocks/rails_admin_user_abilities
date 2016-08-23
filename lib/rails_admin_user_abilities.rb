require "rails_admin_user_abilities/version"

require 'mongoid'
require 'mongoid_userstamp'

require "rails_admin_user_abilities/engine"

require 'rails_admin_user_abilities/configuration'

require 'rails_admin/config/actions'
require 'rails_admin/config/model'
require 'rails_admin_user_abilities/action'
# require 'rails_admin_user_abilities/model'
require 'rails_admin_user_abilities/helper'

module RailsAdminUserAbilities
  class << self
    def orm
      :mongoid
      # if defined?(::Mongoid)
      #   :mongoid
      # else
      #   :active_record
      # end
    end
    def mongoid?
      orm == :mongoid
    end
    def active_record?
      orm == :active_record
    end

    def model_namespace
      "RailsAdminUserAbilities::Models::#{RailsAdminUserAbilities.orm.to_s.camelize}"
    end
    def orm_specific(name)
      "#{model_namespace}::#{name}".constantize
    end
  end

  module Models
    autoload :UserAbility, "rails_admin_user_abilities/models/user_ability"

    module Mongoid
      autoload :UserAbility, "rails_admin_user_abilities/models/mongoid/user_ability"
    end
  end
  # autoload :RailsAdminConfig,  "rails_admin_comments/rails_admin_config"
end
