require_relative 'item'
require 'delegate'

class WrappedItem < SimpleDelegator
  def self.wrap(item)
    case item.name
      when "Aged Brie"
        AgedBrie.new(item)
      when /Conjured/
        ConjuredItem.new(item)
      else
        new(item)
    end
  end

  def update
    return if name == "Sulfuras, Hand of Ragnaros"

    make_older
    adjust_quality
  end

  def make_older
    self.sell_in -= 1
  end

  def adjust_quality
    self.quality += quality_adjustment
  end

  def quality_adjustment
    case name
      when /Backstage passes/
        adjustment = 0
        adjustment += 1
        if sell_in < 10
          adjustment += 1
        end
        if sell_in < 5
          adjustment += 1
        end
        if sell_in < 0
          adjustment = -quality
        end
        return adjustment
      else
        return sell_in < 0 ? -2 : -1
    end
  end

  def quality=(value)
    new_value = [0, value].max
    new_value = [new_value, 50].min
    super(new_value)
  end
end

class AgedBrie < WrappedItem
  def quality_adjustment
    sell_in < 0 ? 2 : 1
  end
end

class ConjuredItem < WrappedItem
  def quality_adjustment
    sell_in < 0 ? -4 : -2
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
      WrappedItem.wrap(item).update
    end
  end
end
