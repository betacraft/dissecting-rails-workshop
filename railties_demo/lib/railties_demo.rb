require "railties_demo/version"
require "railties_demo/railtie"

module RailtiesDemo
  class SnakamelMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      # Step 1: Process the incoming request  # # # # # # # # # #
      @request = ActionDispatch::Request.new(env)
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
      puts '+--E N D --+' * 6
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
      request.request_parameters = input
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
      puts 'before:'
      body.each { |b| puts b }
      puts '+💎+' * 30
      json = JSON.parse(body.each.next)
      json.deep_transform_keys! { |k| k.camelize(:lower) }
      puts 'after:', json
      [json.to_json]
    end
  end
end
