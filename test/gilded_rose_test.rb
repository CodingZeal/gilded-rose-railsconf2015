require_relative 'helper'
require 'approvals'

class GildedRoseTest < Minitest::Test
  def setup
    @gilded_rose = GildedRose.new
  end

  20.times do |i|
    define_method("test_after_#{i}_updates") do
      i.times { @gilded_rose.update_quality }
      Approvals.verify(items, name: "after #{i} updates")
    end
  end

  def test_normal_item
    item = Item.new("+5 Dexterity Vest", 10, 20)
    @gilded_rose.update_item(item)
    assert_equal 9, item.sell_in, "sell in"
    assert_equal 19, item.quality, "quality"
  end

  def test_normal_item_past_sell_in
    item = Item.new("+5 Dexterity Vest", 0, 20)
    @gilded_rose.update_item(item)
    assert_equal -1, item.sell_in, "sell in"
    assert_equal 18, item.quality, "quality"
  end

  def test_conjured_item
    item = Item.new("Conjured Mana Cake", 3, 6)
    @gilded_rose.update_item(item)
    assert_equal 2, item.sell_in
    assert_equal 4, item.quality
  end

  def test_conjured_item_past_sell_in
    item = Item.new("Conjured Mana Cake", 0, 6)
    @gilded_rose.update_item(item)
    assert_equal -1, item.sell_in
    assert_equal 2, item.quality
  end

  def items
    @gilded_rose.instance_variable_get(:@items).map do |item|
      "Name: #{item.name} Sell in: #{item.sell_in} Quality: #{item.quality}"
    end
  end
end
