require "approvals/rspec"

RSpec.describe GildedRose do

  20.times do |i|
    specify "after #{i} updates" do
      i.times { subject.update_quality }
      verify { items }
    end
  end

  def items
    subject.instance_variable_get("@items").map do |item|
      "Name: #{item.name} Sell-in: #{item.sell_in} Quality: #{item.quality}"
    end
  end

end
