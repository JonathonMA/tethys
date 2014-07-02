module Tethys
  class Aggregate < ActiveRecord::Base
    has_many :event_sets, -> { order :version }

    def event_collection
      event_sets.map(&:event_collection).inject(:+)
    end

    def append_event_collection collection
      event_sets.create!(
        event_collection: collection,
        version: collection.version,
      )
      update_attributes! version: collection.version
    end

    def aggregate_class
      aggregate_type.constantize
    end

    delegate :events, to: :event_collection
  end
end
