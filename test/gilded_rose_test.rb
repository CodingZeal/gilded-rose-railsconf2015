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

  def items
    @gilded_rose.instance_variable_get(:@items).map do |item|
      "Name: #{item.name} Sell in: #{item.sell_in} Quality: #{item.quality}"
    end
  end
end
