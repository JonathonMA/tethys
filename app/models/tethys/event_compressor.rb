module Tethys
  class EventCompressor
    def run
      aggregates_with_too_many_events.each do |aggregate|
        aggregate.transaction do
          aggregate.with_lock do
            compress_events(aggregate)
          end
        end
      end
    end

    private

    def aggregates_with_too_many_events
      Aggregate.all
    end

    def compress_events(aggregate)
      event_collection = aggregate.event_collection
      aggregate.event_sets.destroy_all
      aggregate.event_sets.create!(
        data: event_collection.dump,
        version: aggregate.version,
      )
    end
  end
end
