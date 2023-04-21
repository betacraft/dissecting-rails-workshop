# Rack

A simple Ruby application demonstrating how Rack works.
It's a simple CRUD application for Events using GET, POST, PUT and DELETE requests which handles request parameters, renders HTML and returns redirect responses.

## Installation

```bash
bundle
```

## Usage

There are two ways of running the web application.

1. Using `rackup`:

```bash
# if using the Puma server
bundle exec rackup -s puma
```

2. Using `ruby`:

```bash
bundle exec app.rb
```

*Note: changes in code will only reflect on restarting the server if using `ruby`.*
