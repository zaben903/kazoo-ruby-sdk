# KazooSDK

## NOTICE
This SDK is looking for maintainers, interested?  Let us know!

## Installation

Add this line to your application's Gemfile:

```ruby
# Via RubyGems (not yet published)
gem 'kazoo_sdk'

# Via Git
gem 'kazoo_sdk', git: 'https://github.com/2600hz/kazoo-ruby-sdk.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kazoo_sdk

## Usage

```ruby
# With a username and password
client = KazooSDK::Client.new(username: 'your_username', password: 'your_password', account_name: 'your_account_name')

# With an API key
client = KazooSDK::Client.new(api_key: 'your_api_key')
```

### Resource

These are mapped to the Crossbar API as closely as possible.

For example, to get the client default account:

```ruby
client.account.get
```

Getting a device:

```ruby
client.account.device('account_id').get('device_id')
# Or when using the default account
client.account.device.get('device_id')
```

## License

The gem is available as open source under the terms of the [GNU Lesser General Public License v3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html).
