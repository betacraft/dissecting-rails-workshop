class RackApp

  def call(env)
    request = Rack::Request.new env
    if request.path_info == '/' && request.get?
      response = Rack::Response.new
      markup = <<~HTML
        <!doctype html>
        <html>
          <body>
            <h1>Hello from Rack!</h1>
            <a href="/events/">Go to Events App</a>
          </body>
        </html>
      HTML
      response.write markup
      response.finish
    else
      [
        Rack::Utils.status_code(:not_found),
        {
          Rack::CONTENT_TYPE => 'text/plain'
        },
        ["Not Found: #{request.path_info}\n"]
      ]
    end
  end
end
