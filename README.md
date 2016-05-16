# RailsAdminUserAbilities

That will add fields for access to models, objects and actions in rails_admin panel for specific users.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_admin_user_abilities'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_admin_user_abilities

## Usage

Add in app/models/user.rb (temporary decision, it will be more configurable in future)
```ruby
  has_one :ability, class_name: "RailsAdminUserAbilities::UserAbility", as: :rails_admin_user_abilitable
  scope :for_rails_admin, -> { where(:roles.in => ['admin', 'manager']) } # could be any you want, just need to
```

Add actions for rails_admin panel (in initializers/raisl_admin.rb)
```ruby
RailsAdmin.config do |config|
  # some code
  config.actions do
    # some code

    user_abilities do
      visible do
        render_object = (bindings[:controller] || bindings[:view])
        render_object and render_object.current_user.admin? and
        ["User"].include? bindings[:abstract_model].model_name
      end
    end
    model_accesses do
      visible do
        render_object = (bindings[:controller] || bindings[:view])
        render_object and render_object.current_user.admin? and
        ["SomeModel1", "SomeModel2"].include? bindings[:abstract_model].model_name
      end
    end
  end
end
```

Also add method for set CanCanCan rules (in app/models/ability.rb)
```ruby
class Ability
  include CanCan::Ability
  # some code

  def initialize(user)
    # some code
    user.ability.to_cancancan(self) if user.ability
  end
end  
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/enjoycreative/rails_admin_user_abilities.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
