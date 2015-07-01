require_relative 'item'
require 'delegate'

class WrappedItem < SimpleDelegator
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  AGED_BRIE = "Aged Brie"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  def update
    return if legendary?

    make_older
    adjust_quality
  end

  def adjust_quality
    if name == AGED_BRIE
      self.quality += 1
    elsif name == BACKSTAGE_PASSES
      self.quality += 1
      if sell_in < 10
        self.quality += 1
      end
      if sell_in < 5
        self.quality += 1
      end
    else
      self.quality -= 1
    end
    if expired?
      if name == AGED_BRIE
        self.quality += 1
      elsif name == BACKSTAGE_PASSES
        self.quality = 0
      else
        self.quality -= 1
      end
    end
  end

  def make_older
    self.sell_in -= 1
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
