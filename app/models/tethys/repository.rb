module Tethys
  class Repository
    def save(root)
      # TODO: transactions, locking, precious
      aggregate =
        if root.id
          Aggregate.find_by! id: root.id
        else
          Aggregate.create! aggregate_type: root.class.name
        end

      # TODO: root should know his id and version and this point

      collection = EventCollection.for(
        aggregate.id,
        aggregate.version,
        root.uncommitted_events,
      )

      aggregate.append_event_collection(collection)

      root.id = aggregate.id
      root.uncommitted_events.clear
    end

    def load(id)
      aggregate = Aggregate.find_by! id: id

      aggregate.current_root
    end
  end
end
