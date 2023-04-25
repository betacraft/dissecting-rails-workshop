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
    when /verify_keynote/
      verify_keynote(req)
      #TODO - fix root route check such that if not root route, then 404 should get rendered
    when /\//
      [200, {}, ["Hello World from SimpleRackApp!"]]
    else
      [404, {}, ["Page Not Found"]]
    end
  end

  def verify_keynote(req)
    if CONFERENCE_KEYNOTE_SPEAKERS.include?(req.params['first_name'])
      [200, {}, ["This person is a keynote speaker."]]
    else
      [200, {}, ["This person is not a keynote speaker"]]
    end
  end
end

run SimpleRackApp.new