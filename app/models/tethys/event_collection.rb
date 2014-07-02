require 'oj'

module Tethys
  class EventCollection
    def initialize aggregate_id, from_version: -1, from_events: []
      @aggregate_id = aggregate_id
      @event_descriptors = from_events
      @version = from_version
    end

    def self.from data
      Oj.load data
    end

    def self.for aggregate_id, version, events
      collection = new(aggregate_id, from_version: version)

      events.each do |event|
        collection << event
      end

      collection
    end

    attr_reader :version
    attr_reader :event_descriptors

    def events
      @event_descriptors.map(&:event)
    end

    def first_version
      @event_descriptors.first.version - 1
    end

    def dump
      Oj.dump self
    end

    def << event
      @event_descriptors << EventDescriptor.new(
        @aggregate_id,
        event,
        next_version,
      )
    end

    def + other
      # TODO: Implement Commutivity
      if other.first_version != @version
        raise "non-adjacent event collection"
      end

      self.class.new(
        @aggregate_id,
        from_events: @event_descriptors + other.event_descriptors,
        from_version: other.version,
      )
    end

    private

    def next_version
      @version += 1
    end
  end
end
