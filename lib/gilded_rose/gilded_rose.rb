require_relative 'item'
require 'delegate'

class WrappedItem < SimpleDelegator
  def update
    return if name == "Sulfuras, Hand of Ragnaros"

    make_older
    adjust_quality
  end

  def make_older
    self.sell_in -= 1
  end

  def adjust_quality
    case name
    when "Aged Brie"
      increment_quality
      if sell_in < 0
        increment_quality
      end
    when /Backstage passes/
      increment_quality
      if sell_in < 10
        increment_quality
      end
      if sell_in < 5
        increment_quality
      end
      if sell_in < 0
        self.quality -= quality
      end
    else
      decrement_quality
      if sell_in < 0
        decrement_quality
      end
    end
  end

  def decrement_quality
    if quality > 0
      self.quality -= 1
    end
  end

  def increment_quality
    if quality < 50
      self.quality += 1
    end
  end
end

class GildedRose

  @items = []

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    @items.each do |item|
      WrappedItem.new(item).update
    end
  end
end
