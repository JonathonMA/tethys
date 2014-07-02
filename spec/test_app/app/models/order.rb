class Order
  include Tethys::AggregateRoot

  LineItem = Struct.new :sku, :count

  def initialize
    super

    @line_items = []
  end

  attr_reader :line_items

  events do
    on :item_added, :sku, :count do |event|
      @line_items << LineItem.new(event.sku, event.count)
    end

    on :item_removed, :sku do |event|
      @line_items.delete line_items.find { |li| li.sku == event.sku }
    end
  end

  def add_item sku, count
    raise_event ItemAdded.new(sku, count)
  end

  def remove_item sku
    raise_event ItemRemoved.new(sku)
  end
end
