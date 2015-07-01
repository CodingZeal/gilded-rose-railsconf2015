require_relative 'item'
require 'delegate'

class WrappedItem < SimpleDelegator
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  AGED_BRIE = "Aged Brie"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  def update
    if name != AGED_BRIE && name != BACKSTAGE_PASSES
      if quality > 0
        if name != SULFURAS
          self.quality -= 1
        end
      end
    else
      if quality < 50
        self.quality += 1
        if name == BACKSTAGE_PASSES
          if sell_in < 11
            increment_quality
          end
          if sell_in < 6
            increment_quality
          end
        end
      end
    end
    if name != SULFURAS
      self.sell_in -= 1
    end
    if expired?
      if name != AGED_BRIE
        if name != BACKSTAGE_PASSES
          if quality > 0
            if name != SULFURAS
              self.quality -= 1
            end
          end
        else
          self.quality -= quality
        end
      else
        increment_quality
      end
    end
  end

  def increment_quality
    if quality < 50
      self.quality += 1
    end
  end

  def expired?
    sell_in < 0
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
    @items.each { |item| WrappedItem.new(item).update }
  end
end
