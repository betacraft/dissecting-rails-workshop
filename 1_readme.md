# Resource
* https://api.rubyonrails.org/classes/Rails/Railtie.html

# What is Railtie?
Rails::Railtie is the core of the Rails framework and provides several hooks to extend Rails and/or modify the initialization process.

Developing a Rails extension does not require implementing a railtie, but if you need to interact with the Rails framework during or after boot, then a railtie is needed.

For example, an extension doing any of the following would need a railtie:
- creating initializers
- configuring a Rails framework for the application, like setting a generator
- adding config.* keys to the environment
- setting up a subscriber with ActiveSupport::Notifications
- adding Rake tasks


