## Exercise 1 - Rack and Middleware

### Prerequisites -

Make sure you have below things ready and installed -
```ruby
ruby 3.2.2    # ruby --version
rails 7.0.4.3 # rails --version
rackup 1.0    # rackup --v
rack-contrib
```

The Gemfile has the necessary dependencies specified. To install, run below command -
```ruby
bundle
```


### 1.1 Build simple Rack Application -

Build a simple rack application that just renders the string "Hello World!". Let's name this as SimpleRackApp.


### 1.2 Add a simple action that checks if a speaker is keynote speaker or not

We have standard list of keynote speakers for the conference as -
```ruby
CONFERENCE_KEYNOTE_SPEAKERS = [
  'eileen',
  'gary',
  'rafael',
  'shani',
  'aaron'
]
```
The application should accept `first_name` parameter and check if speaker is keynote speaker or not.

Hint: You can create a Rack::Request object from the env hash and use it to access the request parameters.
```ruby
request = Rack::Request.new(env)
request.params['first_name'] #=> 'noel'
```

Expected Responses:
```ruby
'This person is a keynote speaker.'
OR
'This person is not a keynote speaker.'
```

### 1.3 Add a Rack middleware so that mobile developers can keep their camelcase styles

The endpoint built in this exercise will be used by a mobile application that prefers sending and receiving the parameters in camel case format instead of snake case format. You might have come across such use cases quite often. Build a Rack middleware and use with our SimpleRackApp.
The middleware should only modify the response body if its content type is `application/json`.
```ruby
class Middleware
  def initialize(app)
    # @app could be a rack app or another middleware
    @app = app
  end

  def call(env)
    # 1. you can process the incoming request by operating on the env hash before passing it to @app
    
    # 2. invoke the call method on @app by passing the modified/unmodified env and obtain the response
    _status, _headers, _body = response = @app.call(env)
    
    # 3. you can process the outbound response before returning it to the previous layer
    response # modified by middleware/as-is from @app
  end
end
```

### 1.4 Add a Rack middleware to handle JSON request bodies
Out of the box, Rack does not parse JSON request bodies [Content-Type: application/json] into Rack::Request#params. We need to add a middleware to parse the JSON request body and add it to the request params hash.
The rack-contrib gem is a collection of multiple community contributed middlewares.
Let's use the Rack::JSONBodyParser middleware from rack-contrib gem as a quick solution.

You can use the following test requests:
```bash
# Desc: Keynote speaker
curl -X POST "http://127.0.0.1:9292/verify_keynote" \
 -H "content-type: application/json" \
 -d '{"firstName":"eileen"}'

# Desc: Not a Keynote speaker
curl -X POST "http://127.0.0.1:9292/verify_keynote" \
 -H "content-type: application/json" \
 -d '{"firstName":"rtdp"}'
```

