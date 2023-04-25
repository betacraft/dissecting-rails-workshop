# Exercise 2: Active Record, Templating and Action Mailer

## Prerequisites and Setup

Run the following commands:

```bash
cd exercise_2_active_record
bundle # install dependencies declared in Gemfile
bundle exec rake # to run migrations and seed database
```

## 2.1 - ActiveRecord : Write an User class and get all Active Record powers to it.

To get started with creating a Active Record model, use the following:

```ruby
require 'active_record'

# for connecting to the database
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: 'exercise_2_active_record.sqlite3'
Arel::Table.engine = ActiveRecord::Base

class User < ActiveRecord::Base
end
```

We have a sqlite3 database with a `users` table that has `name` and `email` columns. Try out:

1. Use ActiveRecord to fetch the count of users in the database
2. Fetch the first and last User record from the database

## 2.2 - Templating : Render an ERB template with sample email content

Here is a sample code that shows how a template string with variables can be evaluated in current binding.

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

Use the template file `notification_mail.erb` under the `misc` directory and:

1. Render the template using the `erb` standard library
2. Write that rendered HTML to a file and verify it

## 2.3 - ActionMailer : Send a simple email

To get started with creating a Action Mailer mailer, use the following:

```ruby
require 'action_mailer'
require 'letter_opener'

# so that mails don't actually get sent and it opens up nicely in the browser
ActionMailer::Base.add_delivery_method :letter_opener,
                                       LetterOpener::DeliveryMethod,
                                       location: File.expand_path('tmp/letter_opener', __dir__)
ActionMailer::Base.delivery_method = :letter_opener

class UserMailer < ActionMailer::Base
  # type your code here
end
```

In this exercise:
1. Create `UserMailer` class that has a method called `notification_mailer` and expects a `:user` param
2. Send the mail out calling `deliver_now` on the mailer - UserMailer.notification_mailer(user: user).deliver_now

## 2.4 - Combine all the work completed in exercise 2.1 to 2.3.

Write a script that gets any user from database and sends a HTML formatted email to them using ActionMailer.