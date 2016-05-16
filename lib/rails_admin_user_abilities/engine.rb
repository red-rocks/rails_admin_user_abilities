module RailsAdminUserAbilities
  class Engine < ::Rails::Engine

    initializer "RailsAdminUserAbilities precompile hook", group: :all do |app|
      app.config.assets.precompile += %w(rails_admin/rails_admin_user_abilities.js rails_admin/rails_admin_user_abilities.css)
    end

    initializer 'Include RailsAdminUserAbilities::Helper' do |app|
      ActionView::Base.send :include, RailsAdminUserAbilities::Helper
    end
  end
end
