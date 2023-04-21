#\ -o 0.0.0.0 -p 3000
require 'rack'

require_relative 'rack_app'
require_relative 'event_app'

use Rack::Reloader, 0
# use Rack::CommonLogger # rackup adds this by default
use Rack::MethodOverride
use Rack::ContentType
map('/events') { |builder| builder.run EventApp }
run RackApp.new
