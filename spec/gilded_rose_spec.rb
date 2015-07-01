require 'approvals/rspec'

RSpec.describe GildedRose do
  20.times do |i|
    specify "after #{i} updates" do
      i.times { subject.update_quality }
      verify { items }
    end
  end

  def items
    subject.instance_variable_get(:@items).map do |item|
      "#{item.name}: quality: #{item.quality} sell_in: #{item.sell_in}"
    end
  end
end
