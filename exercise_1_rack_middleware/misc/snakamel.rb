require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string/inflections'
class Snakamel
  def initialize(app)
    @app = app
  end

  def call(env)
    # Step 1: Process the incoming request  # # # # # # # # # #
    @request = Rack::Request.new(env)
    puts '+-----------------------+' * 3
    puts 'Received the incoming request'
    snakify(request.params) if snakify?(env)
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    # Step 2: Pass the request to the next middleware or app
    status, headers, body = @app.call(env)
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    # Step 3: Process the outgoing response # # # # # # # # # #
    puts '+------------------------+' * 3
    puts 'Received the outgoing response'
    body = camelize(body) if camelize?(env)
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    # Step 4: Pass the response to the previous middleware or client
    [status, headers, body]
  end

  private

  attr_accessor :request

  def snakify(input)
    puts 'snakifying the request body'
    puts 'before:', input
    input.deep_transform_keys!(&:underscore)
    puts '+💎+' * 30
    puts "after:", input
    request.params.keys.each{ |k| request.delete_param(k) }
    input.each{ |k, v| request.update_param(k, v) }
  end

  def snakify?(env)
    true # this could be a configuration
    # for e.g. we could perform this transformation only if certain HTTP headers are present
    # env['CONTENT_TYPE'] == 'application/json' && env['HTTP_PLATFORM'] == 'web'
  end
  # we could define a different method for camelize? if needed but in this case since let us assume
  # that we want to perform transformation in both directions, we can use the same method
  alias_method :camelize?, :snakify?

  def camelize(body)
    puts 'camelize the response body'
    puts 'before:', body.first
    puts '+💎+' * 30
    json = JSON.parse(body.first)
    json.deep_transform_keys! { |k| k.camelize(:lower) }
    puts 'after:', json
    [json.to_json]
  end
end
