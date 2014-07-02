require 'rails_helper'

module Tethys
  describe Repository do
    let(:sku1) { "SKU-123" }
    let(:sku2) { "SKU-42" }
    let(:repo) { Repository.new }
    let(:order) { Order.new }

    it "should allow me to add things" do

      order.add_item sku1, 2
      order.add_item sku2, 2
      repo.save order

      order.remove_item sku1
      repo.save order

      new_order = repo.load order.id

      expect(new_order.line_items).to eq order.line_items
    end

    let(:event_sets) { 3 }
    let(:events_per_set) { 3 }
    let(:number_of_events) { event_sets * events_per_set }

    it "should compress EventSets to save on rows :)" do
      event_sets.times do |i|
        events_per_set.times do |j|
          order.add_item "SKU#{i}#{j}", i + j
        end

        repo.save order
      end

      expect(EventSet.count).to eq event_sets

      EventCompressor.new.run

      expect(EventSet.count).to eq 1
      expect(EventSet.first.event_collection.events.size).to eq number_of_events
      expect(Aggregate.first.event_collection.events.size).to eq number_of_events

      order2 = repo.load order.id

      expect(order2.line_items).to eq order.line_items
    end
  end
end
