require_relative 'item'

class GildedRose

  @items = []

  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  AGED_BRIE = "Aged Brie"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new(AGED_BRIE, 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new(SULFURAS, 0, 80)
    @items << Item.new(BACKSTAGE_PASSES, 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    @items.each { |item| update_item(item) }
  end

  def update_item(current_item)
    if current_item.name != AGED_BRIE && current_item.name != BACKSTAGE_PASSES
      if current_item.quality > 0
        if current_item.name != SULFURAS
          current_item.quality -= 1
        end
      end
    else
      if current_item.quality < 50
        current_item.quality += 1
        if current_item.name == BACKSTAGE_PASSES
          if current_item.sell_in < 11
            if current_item.quality < 50
              current_item.quality += 1
            end
          end
          if current_item.sell_in < 6
            if current_item.quality < 50
              current_item.quality += 1
            end
          end
        end
      end
    end
    if current_item.name != SULFURAS
      current_item.sell_in -= 1
    end
    if current_item.sell_in < 0
      if current_item.name != AGED_BRIE
        if current_item.name != BACKSTAGE_PASSES
          if current_item.quality > 0
            if current_item.name != SULFURAS
              current_item.quality -= 1
            end
          end
        else
          current_item.quality -= current_item.quality
        end
      else
        if current_item.quality < 50
          current_item.quality += 1
        end
      end
    end
  end

end
