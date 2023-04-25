## Exercise 1 - Rack and Middleware

### Prerequisites -

Make sure you have below things ready and installed - 
```ruby
ruby 3.2.2    # ruby --version
rails 7.0.4.3 # rails --version
rackup 1.0    # rackup --v
rack-contrib
```

To install exact version of Rails mentioned above, use below command - 
```ruby
gem install rails -v 7.0.4.3
```

To install rackup, run below command - 
```ruby
gem install rackup -v 1.0
```

To install rack-contrib, run below command -
```ruby
gem install rack-contrib
```


### 1.1 Build simple Rack Application - 

Build a simple rack application that just renders the string "Hello World!". Let's name this as SimpleRackApp.


### 1.2 Add an simple action that checks if a speaker is keynote speaker or not 

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

### 1.3 Add a middleware so that mobile developers can keep their camelcase styles

The endpoint build in this exercise will be used by a mobile application that really prefers sending and receiving the parameters in came case format instead of snake case format. You might have come across such use cases quite often. Build a middleware and use with our SimpleRackApp.