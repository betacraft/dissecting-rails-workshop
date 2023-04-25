# Exercise 2: Active Record, Templating and Action Mailer

## Prerequisites and Setup

Run the following commands:

```bash
cd active_record
bundle # install dependencies declared in Gemfile
bundle exec rake # to run migrations and seed database
```

## 2.1 - Write an User class and get all Active Record powers to it.

To get started with creating a Active Record model, use the following:

```ruby
require 'active_record'

# for connecting to the database
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: 'active_record.sqlite3'
Arel::Table.engine = ActiveRecord::Base

class User < ActiveRecord::Base
end
```

We have a sqlite3 database with a `users` table with `name` and `email` columns. Then try out:

1. using Active Record to fetch the count of Users in the database
2. print the first and last User record in the database

## 2.2 - Render an ERB template with sample email content

To get started with this, use the following:

```ruby
require 'erb'

template = ERB.new <<~HTML
<!DOCTYPE html>
<html>
<body>
  <h1>Hi, <%= @user.name %>!</h1>
</body>
</html>
HTML
User = Struct.new(:name)
@user = User.new 'Example User'
puts template.result binding
```

Taking the template file `notification_mail.erb` under the `misc` directory and try to:

1. render that using the `erb` standard library
2. write that rendered HTML to a file and verify that it actually rendered it

## 2.3 - Send a simple email out with Action Mailer

To get started with creating a Action Mailer mailer, use the following:

```ruby
require 'action_mailer'
require 'letter_opener'

# so that mails don't actually get sent and it opens up nicely in the browser instead
ActionMailer::Base.add_delivery_method :letter_opener,
                                       LetterOpener::DeliveryMethod,
                                       location: File.expand_path('tmp/letter_opener', __dir__)
ActionMailer::Base.delivery_method = :letter_opener

class UserMailer < ActionMailer::Base
  # type your code here
end
```

1. create a method in the `UserMailer` called `notification_mailer` that expects a `:user` param
2. set the subject and body of the mail to be specific to the User, using their name and email. You have access to helpers like `email_address_with_name(address, name)` which you may use in your scripts
3. send that mail out calling `deliver_now` on the mailer

_Note: It's fine for now to have the mail body just be a plain text one._

## 2.4 - Write a script to find the first User and send a rendered HTML email to them using Action Mailer

Try and use whatever we have built (in steps 2.1 till 2.3) so far to solve this.
