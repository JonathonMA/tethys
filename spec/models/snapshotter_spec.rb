require 'rails_helper'

module Tethys
  describe Snapshotter do
    let(:sku1) { "SKU-123" }
    let(:sku2) { "SKU-42" }
    let(:repo) { Repository.new }
    let(:order) { Order.new }

    let(:event_sets) { 3 }
    let(:events_per_set) { 3 }
    let(:number_of_events) { event_sets * events_per_set }

    it "should snapshot things" do
      event_sets.times do |i|
        events_per_set.times do |j|
          order.add_item "SKU#{i}#{j}", i + j
        end

        repo.save order
      end

      expect(EventSet.count).to eq event_sets

      Snapshotter.new.run

      aggregate = Aggregate.find order.id

      order2 = aggregate.snapshot.root_snapshot

      expect(order2.line_items).to eq order.line_items
    end
  end
end
