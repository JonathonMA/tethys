require 'rails_helper'

module Tethys
  describe AggregateRoot do
    it "should provide Event-Sourced objects" do
      order = Order.new

      order.add_item "TX123", 3

      expect(order.line_items).to include Order::LineItem.new("TX123", 3)
      expect(order.uncommitted_events).to include Order::ItemAdded.new("TX123", 3)

      order.remove_item "TX123"

      expect(order.line_items).to_not include Order::LineItem.new("TX123", 3)
      expect(order.uncommitted_events).to include Order::ItemRemoved.new("TX123")
    end
  end
end
