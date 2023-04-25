require 'zlib'

class Pony
  PonyString = Zlib::Inflate.inflate("eJyFkkFuxCAMRfdzCisbJxK2D5D2JpbMrlI3XXQZDt9PCG0ySgcWIMT79rcN0XClUJlZRB9jVmci
  FmV19khjgRFl0RzrKmqzvY8lRUWFlXvCrD7UbAQR/17NUvGhypAF9og16vWtkC8DzUayS6pN3/dR
  ki0OnpzKjUBFpmlC7zVFRNL1rwoq6PWXXQSnIm9WoTzlM2//ke21o5g/l1ckRhiPbkDZXsKIR7l1
  36hF9uMhnRiVjI8UgYjlsIKCrXXpcA9iX5y7zMmtG0fUpW61Ssttipf6cp3WARfkMVoYFryi2a+w
  o/2dhW0OXfcMTnmh53oR9egzPs+qkpY9IKxdUVRP5wHO7UDAuI6moA2N+/z4vtc2k8B+AIBimVU=".delete("\n ").unpack("m*")[0])

  UnicornString = Zlib::Inflate.inflate("eJyVVD1vhDAM3e9XeAtIxB5P6qlDx0OMXVBzSpZOHdsxP762E0JAnMgZ8Zn37OePAPC60eV1Dl5b
  SS7fB6DmQNGhtegpNlPIQS8HmkYGdSqNqDF9wcMYus4TuBYGsZwIPqXfEoNir5K+R3mbzhlR4JMW
  eGpikPpn9wHl2sDgEH1270guZwzKDRf3nTztMvfI5r3fJqEmNxdCyISBcWjNgjPG8Egg2hgT3mJi
  KBwNvmPB1hbWJ3TwBfMlqdTzxNyDE2H8zOD5HA4KkqJGPVY/TwnxmPA82kdSJNj7zs+R0d1pB+JO
  xn2DKgsdxAfFS2pfTSD0Fb6Uzv7dCQSvE5JmZQEQ90vNjBU1GPuGQpCPS8cGo+dQgjIKqxnJTXbw
  ucFzPFVIJXtzk6BXKGPnYsKzvFmGx7A0j6Zqvlvk5rETXbMWTGWj0RFc8QNPYVfhJfMMniCPazWJ
  lGtPZecIGJWW6oL2hpbWRZEkChe8eg5Wb7xx/MBZBFjxeZPEss+mRQ3Uhc8WQv684seSRO7i3nb4
  7HlKUg8sraz47LmXyh8S0somADvoUpoHjGWl+rUkF0H+EIf/gbyyMg58BBk6L634/fkHUCodMw==".delete("\n ").unpack("m*")[0])

  def call(env)
    if env['QUERY_STRING'].include?("horn")
      animal = UnicornString
      href = "?"
    else
      animal = PonyString
      href = "?horn"
    end

    content = ["<title>Paste:Pony=Rack:Lobster!</title>",
               "<pre>", animal, "</pre>",
               "<a href='#{href}'>horn!</a>"]
    length = content.inject(0) { |a, e| a + e.size }.to_s
    [200, { 'content-type' => "text/html", 'content-length' => length }, content]
  end
end
