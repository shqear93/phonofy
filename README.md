# Phonofy

Phonofy is a Ruby gem that simplifies phone number formatting in Ruby applications using the Phonelib library. It integrates seamlessly with Rails applications but can also be used in non-Rails environments. With Phonofy, you can easily parse and format phone number data according to international standards, ensuring that your phone number data is consistent and valid across your application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'phonofy'
```

And then execute:

```shell
bundle
```

Or install it yourself as:

```shell
gem install phonofy
```

## **Usage**
To use phonofy, simply call the **phonofy** method in your Rails model:

```ruby
class User < ApplicationRecord
  phonofy
end
```

This will add phone number validation and formatting to the **phone_number** attribute of the **User** model.

You can also specify a custom attribute name for the phone number:

```ruby
class Contact < ApplicationRecord
  phonofy :mobile_number
end
```

This will add phone number validation and formatting to the **mobile_number** attribute of the **Contact** model.

You can also pass additional options to phonofy to customize its behavior:

```ruby
class User < ApplicationRecord
  phonofy :phone, phonelib: { countries: [:us, :ca], types: [:mobile] }
end
```

This will add phone number validation and formatting to the **phone** attribute of the **User** model, and restrict it to US and Canada mobile phone numbers.


## **Configuration**

You can configure phonofy by creating an initializer file in your Rails application and setting the default options:

```ruby
# config/initializers/phonofy.rb
Phonofy.configure do |config|
  config.default_phonelib_options = { countries: [:us, :ca], types: [:mobile] }
end
```

This will set the default options for phonofy to validate only US and Canada mobile phone numbers using the Phonelib library.

## **International Phone Number Support**

Phonofy supports international phone numbers through the Phonelib gem. You can validate and format phone numbers for specific countries by including the country codes in the countries option:

```ruby
class User < ApplicationRecord
  phonofy :phone, phonelib: { countries: [:us, :gb, :fr] }
end
```

Example usage:

```ruby
user = User.new(phone: "+14155552671")
user.phone(:e164)          # => "+14155552671"
user.phone(:international) # => "+1 415-555-2671"
user.phone(:national)      # => "(415) 555-2671"
user.phone_is_valid?       # => true
```

## **Contributing**

Bug reports and pull requests are welcome on GitHub at https://github.com/shqear93/phonofy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org/) code of conduct.

## **License**

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## **Credits**

phonofy was created by Khaled AbuShqear and is maintained by a community of contributors.