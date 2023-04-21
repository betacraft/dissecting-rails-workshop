require 'active_record'
require 'action_mailer'
require 'letter_opener'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: 'active_record.sqlite3'
Arel::Table.engine = ActiveRecord::Base

ActionMailer::Base.add_delivery_method :letter_opener,
                                       LetterOpener::DeliveryMethod,
                                       location: File.expand_path('tmp/letter_opener', __dir__)

ActionMailer::Base.delivery_method = :letter_opener
