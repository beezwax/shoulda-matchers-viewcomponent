# Shoulda Matchers for ViewComponent

[![Gem Version](https://badge.fury.io/rb/shoulda-matchers-viewcomponent.svg?style=flat)](https://rubygems.org/gems/shoulda-matchers-viewcomponent)
[![CI](https://github.com/beezwax/shoulda-matchers-viewcomponent/actions/workflows/ci.yml/badge.svg)](https://github.com/beezwax/shoulda-matchers-viewcomponent/actions/workflows/ci.yml)
[![Powered by Beezwax](https://img.shields.io/badge/Powered%20By-Beezwax-gold?logo=data:image/svg+xml;charset=utf-8;base64,PHN2ZyB3aWR0aD0iMTA5IiBoZWlnaHQ9IjEwOSIgdmlld0JveD0iMCAwIDEwOSAxMDkiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+DQogICA8Zz4NCiAgICAgIDxwYXRoIGQ9Ik01MC44IDEwNi42MjVDNTkuMSA5OS4zMjUgNjEuOSA5MS42MjUgNjEuOSA5MS42MjVDNjMuMiA4Ny43MjUgNjQuNyA4NC41MjUgNjQuNyA2OS4zMjVDNjQuNyA0Ni40MjUgNTYuMiAzOC45MjUgNDcgMzIuMDI1QzQwLjggMjcuMzI1IDI0LjkgMjEuMTI1IDE1LjUgMTcuNjI1TDIuMjk5OTggMjUuMTI1QzEuNDk5OTggMjUuNzI1IDAuOTk5OTc2IDI2LjIyNSAwLjU5OTk3NiAyNi44MjVDMjQuNCAzMi4xMjUgNDEuNSA0OC4wMjUgNDEuNSA2Ni44MjVDNDEuNSA3OC4yMjUgMzUuMSA4OC42MjUgMjQuOSA5Ni4xMjVMNDQuNyAxMDcuNTI1QzQ1LjEgMTA3LjcyNSA0NiAxMDguMTI1IDQ3LjMgMTA4LjEyNUM0Ny45IDEwOC4xMjUgNDkgMTA3LjkyNSA1MC4zIDEwNi44MjVMNTAuOCAxMDYuNjI1WiIgZmlsbD0iI0ZGRDkzOSI+PC9wYXRoPg0KICAgICAgPHBhdGggZD0iTTIyLjkgMTMuMzI0OEw0NCAyMC40MjQ4QzY0LjYgMjcuNzI0OCA3My4yIDM3LjgyNDggNzMuMiAzNy44MjQ4Qzg0LjUgNDkuMTI0OCA4My4yIDYxLjYyNDggODMuMiA3Ni44MjQ4QzgzLjIgODAuNjI0OCA4Mi42IDg0LjkyNDggODEuNyA4OS4wMjQ4TDkzIDgyLjYyNDhDOTUuNiA4MS4xMjQ4IDk1LjYgNzcuOTI0OCA5NS42IDc3LjkyNDhWMjkuMzI0OEM5NS42IDI2LjEyNDggOTMgMjQuNjI0OCA5MyAyNC42MjQ4TDcyLjUgMTMuMjI0OEw1MC42IDAuNjI0ODQ1QzQ4LjEgLTAuNjc1MTU1IDQ1LjUgMC40MjQ4NDUgNDUuMyAwLjYyNDg0NUwyMy4xIDEzLjMyNDhIMjIuOVoiIGZpbGw9IiNGRkQ5MzkiPjwvcGF0aD4NCiAgICAgIDxwYXRoIGQ9Ik0wLjEgMzEuNTI0NFY3OC4yMjQ0QzAuMSA4MC44MjQ0IDIuMiA4Mi4zMjQ0IDIuNyA4Mi43MjQ0TDE0LjggODkuNjI0NEwxNy44IDkxLjMyNDRDMjQuNCA4NC43MjQ0IDI4LjQgNzYuMzI0NCAyOC41IDY3LjEyNDRDMjguNSA1MS41MjQ0IDE2LjggMzguMDI0NCAwIDMxLjUyNDRIMC4xWiIgZmlsbD0iI0ZGRDkzOSI+PC9wYXRoPg0KICAgPC9nPg0KPC9zdmc+)](https://beezwax.net/)

Adds convenient
[ViewComponent](https://github.com/ViewComponent/view_component) matchers to
[shoulda matchers](https://github.com/thoughtbot/shoulda-matchers).

## Installation

Include `shoulda-matchers-viewcomponent` in your Gemfile:

```ruby
group :test do
  # ...
  gem 'shoulda-matchers-viewcomponent'
end
```

And run `bundle`.

Then configure Shoulda to use the ViewComponent matchers:

```ruby
# If using RSpec, this would typically go in spec/rails_helper.rb
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # ...
    with.library :view_component
  end
end
```

## Usage

At the moment only one matcher exists, `use_collection_parameter`, which
checks that a collection parameter was set for the component through
`with_collection_parameter`. E.g.:

```ruby
# app/components/product_component.rb
class ProductComponent < ViewComponent::Base
  with_collection_parameter :product

  def initialize(product:, product_counter:, product_iteration:)
    # ...
  end
end

# spec/components/product_component_spec.rb
RSpec.describe ProductComponent, type: :component do
  it do
    expect(described_class).to use_collection_parameter(:product)
      .with_counter   # Optional, checks for product_counter: param
      .with_iteration # Optional, checks for product_iteration: param
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can
also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/beezwax/shoulda-matchers-viewcomponent.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
