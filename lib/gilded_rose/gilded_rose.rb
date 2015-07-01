require_relative 'item'
require 'delegate'

class WrappedItem < SimpleDelegator
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  AGED_BRIE = "Aged Brie"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  def update
    if name != AGED_BRIE && name != BACKSTAGE_PASSES
      unless legendary?
        self.quality -= 1
      end
    else
      self.quality += 1
      if name == BACKSTAGE_PASSES
        if sell_in < 11
          self.quality += 1
        end
        if sell_in < 6
          self.quality += 1
        end
      end
    end
    unless legendary?
      self.sell_in -= 1
    end
    if expired?
      if name != AGED_BRIE
        if name != BACKSTAGE_PASSES
          unless legendary?
            self.quality -= 1
          end
        else
          self.quality = 0
        end
      else
        self.quality += 1
      end
    end
  end

  def quality=(new_quality)
    new_quality = 50 if new_quality > 50
    new_quality = 0 if new_quality < 0
    super(new_quality)
  end

  def legendary?
    name == SULFURAS
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
