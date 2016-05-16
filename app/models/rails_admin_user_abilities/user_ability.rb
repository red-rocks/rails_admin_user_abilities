if RailsAdminUserAbilities.active_record?
  module RailsAdminUserAbilities
    class UserAbility < ActiveRecord::Base
    end
  end
end

module RailsAdminUserAbilities
  class UserAbility
    #binding.pry
    if RailsAdminUserAbilities.mongoid?
      include RailsAdminUserAbilities::Models::UserAbility
    end

    if RailsAdminUserAbilities.active_record?
      self.table_name = "rails_admin_user_abilities"
    end

  end
end
