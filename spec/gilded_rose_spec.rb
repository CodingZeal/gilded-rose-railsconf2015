require "approvals/rspec"

RSpec.describe GildedRose do
  let(:items) do
    subject.items.map do |item|
      "Name: #{item.name} Sell-in: #{item.sell_in} Quality: #{item.quality}"
    end
  end

  20.times do |i|
    specify "after #{i} updates" do
      i.times { subject.update_quality }
      verify { items }
    end
  end

  describe "conjured items" do
    let(:item) { Item.new("Conjured something", 5, 10) }
    before do
      subject.update_item(item)
    end

    it "decreases quality by 2 each day" do
      expect(item.quality).to eq 8
    end

    it "decreases sell_in by 1 each day" do
      expect(item.sell_in).to eq 4
    end

    context "past the sell_in date" do
      let(:item) { Item.new("Conjured old item", -1, 10) }

      it "decreases twice as fast" do
        expect(item.quality).to eq 6
      end
    end
  end
end
