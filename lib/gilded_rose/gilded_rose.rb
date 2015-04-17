require_relative 'item'

class GildedRose
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
      if item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality -= 1
          end
        end
      else
        if item.quality < 50
          item.quality += 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality += 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality += 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in -= 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality -= 1
              end
            end
          else
            item.quality = 0
          end
        else
          if item.quality < 50
            item.quality += 1
          end
        end
      end
    end
  end

end
