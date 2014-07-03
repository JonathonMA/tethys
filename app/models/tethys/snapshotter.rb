module Tethys
  class Snapshotter
    def run
      outdated_aggregates.each do |aggregate|
        # TODO: Performance: Replay only since last snapshot
        snapshot = aggregate.snapshot
        snapshot.root_snapshot = aggregate.current_root
        snapshot.save!
      end
    end

    def outdated_aggregates
      Aggregate.all
    end
  end
end
