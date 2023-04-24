module RailtiesDemo
  class Railtie < ::Rails::Railtie
    initializer "railties_demo.configure_rails_initialization" do |app|
      app.middleware.use RailtiesDemo::SnakamelMiddleware
    end
  end
end
