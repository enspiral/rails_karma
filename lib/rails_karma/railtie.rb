require 'rails_karma'
require 'rails'
module RailsKarma
  class Railtie < Rails::Railtie
    rake_tasks do
      require 'rails_karma/tasks'
    end
  end
end