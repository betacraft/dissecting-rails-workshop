# Exercise 2 : Active Record, Templating and ActionMailer

### Prerequisites and setup -

Run the following command:

```bash
cd active_record
bundle # install dependencies declared in Gemfile
bundle exec rake # to run migrations and seed database
```

### 2.1 - Write an User class and get all ActiveRecord powers to it.

To get started with creating a Active Record model, use the following:

```ruby
require 'active_record'

class User < ActiveRecord::Base
  # type your code here
end
```

We have a sqlite3 database with a `users` table with `name` and `email` columns. Then try out:

1. connecting to the database using Active Record

Copy this code to get started

```ruby
require 'active_record'

# for connecting to the database
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: 'active_record.sqlite3'
Arel::Table.engine = ActiveRecord::Base
```

2. using Active Record and fetch the count of Users in the database

3. list the Users out with their name and email

4. try creating a User record ensuring presence of name and email fields and correct format of the email

### 2.2 - Render an ERB template with sample email content

We have an ERB template that needs to be rendered. Use the `erb` gem
to render the `notification_mail.erb` template.

### 2.3 - Send an simple email out with ActionMailer

To get started with creating a Active Record model, use the following:

```ruby
require 'action_mailer'

class UserMailer < ActionMailer::Base
  # type your code here
end
```

<!-- write down the steps/challenges the audience can try out, if any -->

### 2.4 - Combine all these different code samples together in single app

# Active Record

You need write an independent service that runs on AWS Lambda to send out emails. This service will be provided with user-id when events trigger - based on those events, you will need to connect with databased, retrieve name and email for that user and send out the email.

Some configuration that can simply copy paste in your scripts:

```ruby
require 'active_record'
require 'action_mailer'
require 'letter_opener'

# for connecting to the database
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: 'active_record.sqlite3'
Arel::Table.engine = ActiveRecord::Base

# so that mails open up nicely in the browser
ActionMailer::Base.add_delivery_method :letter_opener,
                                       LetterOpener::DeliveryMethod,
                                       location: File.expand_path('tmp/letter_opener', __dir__)
ActionMailer::Base.delivery_method = :letter_opener
```

_Note: Don't forget to run `rake` to setup the sqlite3 database._
