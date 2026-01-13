# TudlaContracts

[![Gem Version](https://badge.fury.io/rb/tudla_contracts.svg)](https://badge.fury.io/rb/tudla_contracts)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.txt)
[![Ruby](https://img.shields.io/badge/ruby-%3E%3D%203.0.0-ruby.svg)](https://www.ruby-lang.org)

A shared contracts gem for Tudla integrations. This gem provides base classes, interfaces, and a registry system for building pluggable integrations with the Tudla platform.

## Features

- **Integration Registry** - Thread-safe registration and lookup of integration providers
- **Host Interface** - Abstract interface for host applications to provide user, task, and project data
- **TimeSheet Base** - Base class for building time sheet integrations with a standardized API

## Installation

Add this line to your application's Gemfile:

```ruby
gem "tudla_contracts"
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install tudla_contracts
```

## Requirements

- Ruby >= 3.0.0

## Usage

### Integration Registry

Register your integration provider using fully qualified class name strings:

```ruby
TudlaContracts::Integrations::Registry.register(
  :my_provider,
  type: :time_sheet,
  provider_class: "MyGem::Providers::TimeSheetProvider",
  config_class: "MyGem::Config::TimeSheetConfig"
)
```

Look up registered integrations:

```ruby
# Find a specific provider (returns class name string)
provider_class_name = TudlaContracts::Integrations::Registry.find(:my_provider)
# => "MyGem::Providers::TimeSheetProvider"

# Instantiate the provider
provider = provider_class_name.constantize.new(config)

# Get all providers of a type
time_sheet_providers = TudlaContracts::Integrations::Registry.all_of_type(:time_sheet)

# List available provider names
TudlaContracts::Integrations::Registry.available_providers
# => ["my_provider"]

# Get config class for a provider (returns class name string)
config_class_name = TudlaContracts::Integrations::Registry.config_class_for(:my_provider)
# => "MyGem::Config::TimeSheetConfig"
```

### Host Interface

Implement the host interface to provide data from your application:

```ruby
class MyHostInterface < TudlaContracts::Integrations::HostInterface
  def available_users_for_user(user)
    # Return array of TudlaContracts::Integrations::User structs
  end

  def available_tasks_for_user(user)
    # Return array of TudlaContracts::Integrations::Task structs
  end

  def available_projects_for_user(user)
    # Return array of TudlaContracts::Integrations::Project structs
  end
end
```

Available data structures:

```ruby
TudlaContracts::Integrations::User.new(id:, name:, email:)
TudlaContracts::Integrations::Task.new(id:, name:, project_name:)
TudlaContracts::Integrations::Project.new(id:, name:)
```

### TimeSheet Integration

Create a time sheet provider by extending the base class:

```ruby
class MyTimeSheetProvider < TudlaContracts::TimeSheet::Base
  def daily_activities(user, date, task_ids = nil)
    # Fetch and return activities for the given date
    # Returns array of TudlaContracts::TimeSheet::ActivitySummary
  end
end
```

Activity summary structure:

```ruby
TudlaContracts::TimeSheet::ActivitySummary.new(
  task_id:,
  total_seconds:,
  notes:,
  remote_id:,
  metadata:
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

```bash
# Install dependencies
bin/setup

# Run tests
bundle exec rake spec

# Run linter
bundle exec rubocop

# Start interactive console
bin/console
```

To install this gem onto your local machine, run `bundle exec rake install`.

## Releasing

1. Update the version number in `lib/tudla_contracts/version.rb`
2. Update `CHANGELOG.md` with the new version's changes
3. Run `bundle exec rake release` to create a git tag, push commits and tags, and publish to RubyGems

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tibomogul/tudla_contracts. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](CODE_OF_CONDUCT.md).

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Code of Conduct

Everyone interacting in the TudlaContracts project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
