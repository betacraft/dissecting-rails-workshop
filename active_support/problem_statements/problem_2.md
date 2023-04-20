# Problem

## Transform all keys into uppercase

```ruby
hash = { 'a' => 1, 'b' => { 'c' => 2, 'd' => 3 , 'e' => { 'f' => 4, 'g' => 5 } } }
```

## solution

```ruby
def deep_upper_case(hash, result = {})
  hash.each_with_object({}) do |(key, value), result|
    new_key = key.to_s.upcase
    new_value = value.is_a?(Hash) ? deep_upper_case(value, result) : value
    result[new_key] = new_value
  end
end

p deep_upper_case(hash)
```

## solution with active support

```ruby
require 'active_support/all'

new_hash = hash.deep_transform_keys { |key| key.to_s.upcase }
puts new_hash
```
