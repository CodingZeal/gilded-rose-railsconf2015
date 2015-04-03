require_relative 'test_helper'
require_relative '../gilded_rose'

class GildedRoseTest < Minitest::Test
  def setup
    @gilded_rose = GildedRose.new
  end

  def test_does_something
    @gilded_rose.update_quality
  end
end
