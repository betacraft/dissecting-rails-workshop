require_relative 'event'

class EventApp
  def self.call(env)
    new(env).call
  end

  attr_reader :request

  def initialize(env)
    @request = Rack::Request.new env
  end

  def call
    response = []
    # very simple, naive routing
    path_parts = request.path_info
                        .split('/')
                        .reject { |part| part.empty? }
    # %w[<event_id> <action>]
    if path_parts.size.eql? 2
      # poor man's before_action
      if event = Event.event(path_parts[0].to_i)
        case path_parts[1]
        when 'edit'
          if request.get?
            response = Rack::Response.new
            markup = <<~HTML
              <!doctype html>
              <html>
                <body>
                  <h1>Edit Event</h1>
                  <form action="/events/#{event.id}/update" method="POST">
                    <label for="title">Title</label>
                    <input id="title" type="text" name="title" value="#{event.title}" />
                    <br />
                    <br />
                    <input type="hidden" name="_method" value="PATCH" />
                    <input type="submit" name="submit" value="submit" />
                    <input type="reset" name="reset" value="reset" />
                  </form>
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
              ["Not Found\n"]
            ]
          end
        when 'update'
          if request.put? || request.patch?
            response = Rack::Response.new
            if Event.update(event.id, title: request.params['title'])
              response.redirect "/events/#{event.id}/"
            else
              markup = <<~HTML
                <!doctype html>
                <html>
                  <body>
                    <h1>Edit Event</h1>
                    <p style="background-color: rgba(255, 0, 0, 0.5);">Event params invalid!</p>
                    <form action="/events/#{event.id}/update" method="POST">
                      <label for="title">Title</label>
                      <input id="title" type="text" name="title" value="#{event.title}" />
                      <br />
                      <br />
                      <input type="hidden" name="_method" value="PATCH" />
                      <input type="submit" name="submit" value="submit" />
                      <input type="reset" name="reset" value="reset" />
                    </form>
                  </body>
                </html>
              HTML
              response.write markup
              response.status = Rack::Utils.status_code :unprocessable_entity
            end
            response.finish
          else
            [
              Rack::Utils.status_code(:not_found),
              {
                Rack::CONTENT_TYPE => 'text/plain'
              },
              ["Not Found\n"]
            ]
          end
        when 'destroy'
          if request.delete?
            event = Event.delete(event.id)
            response = Rack::Response.new
            response.redirect '/events/'
            response.finish
          else
            [
              Rack::Utils.status_code(:not_found),
              {
                Rack::CONTENT_TYPE => 'text/plain'
              },
              ["Not Found\n"]
            ]
          end
        else
          [
            Rack::Utils.status_code(:not_found),
            {
              Rack::CONTENT_TYPE => 'text/plain'
            },
            ["Not Found\n"]
          ]
        end
      else
        [
          Rack::Utils.status_code(:not_found),
          {
            Rack::CONTENT_TYPE => 'text/plain'
          },
          ["Not Found\n"]
        ]
      end
    # %w[<event_id|action>]
    elsif path_parts.size.eql? 1
      case path_parts.first
      when 'new'
        if request.get?
          response = Rack::Response.new
          markup = <<~HTML
            <!doctype html>
            <html>
              <body>
                <h1>Add Event</h1>
                <form action="/events/create" method="POST">
                  <label for="title">Title</label>
                  <input id="title" type="text" name="title" />
                  <br />
                  <br />
                  <input type="submit" name="submit" value="submit" />
                  <input type="reset" name="reset" value="reset" />
                </form>
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
            ["Not Found\n"]
          ]
        end
      when 'create'
        if request.post?
          response = Rack::Response.new
          if event = Event.add(title: request.params['title'])
            response.redirect "/events/#{event.id}/"
          else
            markup = <<~HTML
              <!doctype html>
              <html>
                <body>
                  <h1>Add Event</h1>
                  <p style="background-color: rgba(255, 0, 0, 0.5);">Event params invalid!</p>
                  <form action="/events/create" method="POST">
                    <label for="title">Title</label>
                    <input id="title" type="text" name="title" value="#{request.params['title']}" />
                    <br />
                    <br />
                    <input type="submit" name="submit" value="submit" />
                    <input type="reset" name="reset" value="reset" />
                  </form>
                </body>
              </html>
            HTML
            response.write markup
            response.status = Rack::Utils.status_code :unprocessable_entity
          end
          response.finish
        else
          [
            Rack::Utils.status_code(:not_found),
            {
              Rack::CONTENT_TYPE => 'text/plain'
            },
            ["Not Found\n"]
          ]
        end
      when /\A(\d+)\Z/
        if event = Event.event(Regexp.last_match(1).to_i)
          response = Rack::Response.new
          markup = <<~HTML
            <!doctype html>
            <html>
              <body>
                <h1>#{event.title}</h1>
                <a href="/events/#{event.id}/edit">Edit</a>
                <form action="/events/#{event.id}/destroy/" method="POST">
                  <input type="hidden" name="_method" value="DELETE" />
                  <input type="submit" name="submit" value="Delete" />
                </form>
                <br />
                <a href="/events/">Events</a>
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
            ["Not Found\n"]
          ]
        end
      else
        [
          Rack::Utils.status_code(:not_found),
          {
            Rack::CONTENT_TYPE => 'text/plain'
          },
          ["Not Found\n"]
        ]
      end
    elsif path_parts.size.zero?
      response = Rack::Response.new
      events = Event.events
      if events.count.positive?
        events_markup = events.map do |event|
          <<~HTML
            <li>
              <a href="/events/#{event.id}/">#{event.title}</a>
            </li>
          HTML
        end.join
        events_markup = "<ol>#{events_markup}</ol>"
      else
        events_markup = '<p>No Events added, yet!</p>'
      end
      markup = <<~HTML
        <!doctype html>
        <html>
          <body>
            <h1>Events</h1>
            #{events_markup}
            <a href="/events/new/">Add an Event</a>
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
        ["Not Found\n"]
      ]
    end
  end
end
