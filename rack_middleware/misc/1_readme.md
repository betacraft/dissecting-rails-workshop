# Rack Middlewares
## Like method chaining in Ruby but different
```
Rubyist
    .new(name: "Ratnadeep", handle: "@rtdp")
    .topic("rack-middleware".split("-").map(&:capitalize).join(" "))
    .speak(Date.today)

#=> "♦️ Hello, I am Ratnadeep (@rtdp) and the topic I would like to discuss with you today is Rack Middleware ♦️"
```

### like chaining methods...
[RequestId] ->  [Logger] -> [Rack App]

### ... but different
* Middlewares can inspect the request and response, and can modify them before passing them on to the next middleware in the chain.
  - [RequestId] <-> [Logger] <-> [Speed Gun] <-> [Rack App]
    - Can log both the request and response
    - Can calculate Round trip time at any point in the stack by placing the hypothetical SpeedGun middleware anywhere in the chain.
* They can also short-circuit the chain and return a response.
  - ##### Between 9AM to 5PM
    - [RequestId] <-> [ChrisOliver::NineToFive] <-> [Business Hours only Rack App]

  - ##### Outside of 9AM to 5PM
    - [RequestId] <-> [ChrisOliver::NineToFive] (X) [Business Hours only Rack App]
    
## Resources
- [Rack - Middlewares shipped with Rack](https://github.com/rack/rack#available-middleware-shipped-with-rack)
- [Engine Yard - Understanding Rack Apps & Middleware](https://www.engineyard.com/blog/understanding-rack-apps-and-middleware/)
- [Chris Oliver - NineToFive](https://twitter.com/excid3/status/1593674180255424514)
