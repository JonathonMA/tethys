module Tethys
  class Engine < ::Rails::Engine
    isolate_namespace Tethys

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
