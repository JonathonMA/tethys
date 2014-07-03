require 'oj'

module Tethys
  class EventSet < ActiveRecord::Base
    # Autoloads
    Tethys::EventDescriptor
    Tethys::EventCollection

    belongs_to :aggregate

    def event_collection= collection
      self.data = collection.dump
    end

    def event_collection
      EventCollection.from(data)
    end
  end
end
