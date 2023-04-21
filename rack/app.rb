#!/usr/bin/env ruby
# .rb equivalent of the config.ru contents
require 'rack'
require 'rack/handler/puma'
# these can be interchanged
# require 'rack/handler/thin'
# require 'rack/handler/webrick'

require_relative 'rack_app'
require_relative 'event_app'

app = Rack::Builder.new do |builder|
  # Rack::Reloader does not seem to work if it's used in a .rb file but
  # it works fine in a .ru file
  # builder.use Rack::Reloader, 0
  builder.use Rack::CommonLogger # adding $stdout logging explicitly
  builder.use Rack::MethodOverride
  builder.use Rack::ContentType
  builder.map('/events') { |builder| builder.run EventApp }
  builder.run RackApp.new
end

# Rack::Handler class can be interchanged
handler = Rack::Handler::Puma
# handler = Rack::Handler::Thin
# handler = Rack::Handler::WEBrick
handler.run app, { Host: '0.0.0.0', Port: 3000 }
