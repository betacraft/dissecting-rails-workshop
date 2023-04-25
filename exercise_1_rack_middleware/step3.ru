require 'active_support/all'

class SimpleRackApp

  CONFERENCE_KEYNOTE_SPEAKERS = %w[eileen gary rafael shani aaron]

  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
    when '/verify_keynote'
      verify_keynote(req)
    when '/'
      [200, {'Content-Type' => 'text/plain'}, ["Hello World from SimpleRackApp!"]]
    else
      [404, {'Content-Type' => 'text/plain'}, ["Page Not Found"]]
    end
  end

  def verify_keynote(req)
    puts "====="
    puts req.params
    puts "====="
    if CONFERENCE_KEYNOTE_SPEAKERS.include?(req.params['first_name'])
      [200,
       {'Content-Type' => 'application/json'},
       [
         {
          first_name: req.params['first_name'],
          message: "This person is a keynote speaker."
         }.to_json
       ]
      ]
    else
      [200,
       {'Content-Type' => 'application/json'},
       [
         {
          first_name: req.params['first_name'],
          message: "This person is not a keynote speaker."
         }.to_json
       ]
      ]
    end
  end
end

class Snakamel
  def initialize(app)
    @app = app
  end

  def call(env)
    # Step 1: Process the incoming request  # # # # # # # # # #
    @request = Rack::Request.new(env)
    snakify(request.params)
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    # Step 2: Pass the request to the next middleware or app
    status, headers, body = @app.call(env)
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    # Step 3: Process the outgoing response # # # # # # # # # #
    body = camelize(body) if camelize?(headers)
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    # Step 4: Pass the response to the previous middleware or client
    [status, headers, body]
  end

  private

  attr_accessor :request

  def snakify(input)
    input.deep_transform_keys!(&:underscore)
    request.params.keys.each{ |k| request.delete_param(k) }
    input.each{ |k, v| request.update_param(k, v) }
  end

  def camelize(body)
    json = JSON.parse(body.first)
    json.deep_transform_keys! { |k| k.camelize(:lower) }
    [json.to_json]
  end

  def camelize?(headers)
    # camelize if the response is JSON
    headers['Content-Type'] == 'application/json'
  end
end

use Snakamel
run SimpleRackApp.new