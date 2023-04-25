require 'rack'

class SimpleRackApp
  def call(env)
    [200, {}, ["Hello World!"]]
  end

  def check_registrations(env)
    if env.params['first_name'] == 'noel'
      [200, {}, ["You are registered!"]]
    else
      [200, {}, ["You might not be registered!"]]
    end
  end
end

run SimpleRackApp.new

# run -> (env) do
#   [200, {}, ["Hello World!"]]
# end