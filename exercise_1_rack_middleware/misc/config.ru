require_relative 'sample_app' # can also use require with a path to the file like './sample_app'
require_relative 'snakamel'
# require 'rack/contrib/bounce_favicon'
require 'rack/contrib/json_body_parser'

# use Rack::BounceFavicon
use Rack::JSONBodyParser
use Snakamel
run SampleApp.new
