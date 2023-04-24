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

*Note: Don't forget to run `rake` to setup the sqlite3 database.*