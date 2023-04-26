# Active support

## How to run the demo?

- navigate inside active_support folder
- run `bundle` to install gems
- run `ruby interactive_demo/index.rb`

## About

Active Support is a library that is a part of the Ruby on Rails framework. It provides various utility classes and extensions to the Ruby core classes that help developers write clean and efficient code.

One of the main features of Active Support is its support for handling dates and times. It provides a comprehensive set of classes and methods to work with dates, times, and time zones. It also includes methods to parse and format date and time strings, handle time zones conversions, and deal with daylight saving time changes.

Active Support also provides a set of core extensions to Ruby classes such as Array, Hash, Numeric, and String. These extensions provide additional functionality that makes it easier to work with these classes in a Rails application. For example, the Array class is extended to include methods for extracting and manipulating elements, while the String class is extended to include methods for manipulating strings and converting them to other data types.

In addition, Active Support provides a number of other utilities such as caching, internationalization support, benchmarking, and more. These features help developers to write more efficient and maintainable code.

Overall, Active Support is a key component of the Rails framework, providing developers with a wide range of tools and utilities to simplify the development process and improve the overall quality of their applications.

## Caching

Active Support provides a built-in caching framework that can be used to cache expensive or frequently accessed data. For example, if your application needs to query a database to fetch some data that doesn't change frequently, you can use Active Support caching to store the result of the query in memory or on disk so that subsequent requests can be served faster. Here's an example:

```ruby
Rails.cache.fetch('my_cached_data') do
  # Expensive operation to fetch data goes here
  MyModel.some_expensive_query
end
```

## Internationalization

Active Support provides a set of utilities to support internationalization (i18n) in Rails applications. For example, you can use the t method to look up translations for a given key:

```ruby
# Assuming the translation file has a key "greeting" with the value "Hello, %{name}!"
t('greeting', name: 'Alice') #=> "Hello, Alice!"
```

Active Support also provides support for pluralization, date and time formatting, and more.

## Benchmarking

Active Support provides a simple way to benchmark the performance of your code using the Benchmark module. For example, you can use the Benchmark.measure method to measure the time it takes to execute a block of code:

```ruby
require 'benchmark'

time = Benchmark.measure do
  # Code to be benchmarked goes here
end

puts "Execution time: #{time.real}s"
```

In this example, the Benchmark.measure method will execute the block of code and return a Benchmark::Tms object with information about the execution time. The time.real method returns the real time it took to execute the block in seconds.

## Core Extensions

Active Support provides a number of extensions to core Ruby classes such as Array, Hash, Numeric, and String. These extensions provide additional functionality that makes it easier to work with these classes in a Rails application. For example:

The `Array` class is extended to include methods for extracting and manipulating elements, such as `extract_options`! and `wrap`.
The `Hash` class is extended to include methods for manipulating hashes, such as `reverse_merge` and `deep_merge`.
The `Numeric` class is extended to include methods for converting numbers to different units of measurement, such as `kilobytes` and `megabytes`.
The `String` class is extended to include methods for manipulating strings and converting them to other data types, such as `camelize` and `to_time`.

## Inflector

Active Support provides an Inflector module that provides methods for transforming words between their singular and plural forms, as well as other common transformations such as converting underscores to camel case. For example:

 ```ruby
ActiveSupport::Inflector.pluralize('dog') #=> "dogs"
ActiveSupport::Inflector.singularize('dogs') #=> "dog"
ActiveSupport::Inflector.camelize('some_variable_name') #=> "SomeVariableName"
```

## Conversions

Active Support provides a HashWithIndifferentAccess class that allows you to access keys in a hash using either string or symbol keys. It also provides methods to convert between different data types, such as to_query and to_formatted_s. For example:

```ruby
hash = ActiveSupport::HashWithIndifferentAccess.new(name: 'Alice')
hash[:name] #=> "Alice"
hash['name'] #=> "Alice"

1.hour.to_i #=> 3600
3600.to_duration #=> 1 hour
```

## JSON and XML Parsing

Active Support provides methods to parse and generate JSON and XML data. For example, you can use the `ActiveSupport::JSON.decode` method to parse a JSON string into a Ruby object:

```ruby
json_string = '{"name": "Alice", "age": 30}'
json_data = ActiveSupport::JSON.decode(json_string)
json_data #=> {"name"=>"Alice", "age"=>30}

```

And you can use the ActiveSupport::XmlMini.parse method to parse an XML string into a Ruby object:

```ruby
xml_string = '<person><name>Alice</name><age>30</age></person>'
xml_data = ActiveSupport::XmlMini.parse(xml_string)
xml_data #=> {"person"=>{"name"=>"Alice", "age"=>"30"}}
```
