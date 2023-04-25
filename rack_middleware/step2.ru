class SimpleRackApp

  CONFERENCE_KEYNOTE_SPEAKERS = [
    'eileen',
    'gary',
    'rafael',
    'shani',
    'aaron'
  ]

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
    if CONFERENCE_KEYNOTE_SPEAKERS.include?(req.params['first_name'])
      [200, {'Content-Type' => 'text/plain'}, ["This person is a keynote speaker."]]
    else
      [200, {'Content-Type' => 'text/plain'}, ["This person is not a keynote speaker"]]
    end
  end
end

run SimpleRackApp.new
