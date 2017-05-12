require './models/order'

describe Order do
  subject { Order.new material, discount}
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:discount) { Discount.new }
  let(:standard_delivery) { Delivery.new(:standard, 10.00) }
  let(:express_delivery) { Delivery.new(:express, 20.00, 2, 15.00) }

  before(:each) do
    @broadcaster_1 = Broadcaster.new(1, 'Viacom')
    @broadcaster_2 = Broadcaster.new(2, 'Disney')
    @broadcaster_3 = Broadcaster.new(3, 'Discovery')
  end

  context 'when initialized' do
    it 'has an instance of material' do
      expect(subject.material).to be_a Material
    end

    it 'has an instance of discount' do
      expect(subject.discount).to be_a Discount
    end

    it 'has an empty items array' do
      expect(subject.items).to eq([])
    end

    it 'has the accumulated discount saved on delivery' do
      expect(subject.total_delivery_discount).to eq(0)
    end

    it 'has the discount saved on total cost' do
      expect(subject.total_cost_discount).to eq(0)
    end
  end

  context 'empty' do
    it 'costs nothing' do
      expect(subject.total_cost).to eq(0)
    end
  end

  context 'when making an order' do
    it 'adds order to the items array' do
      subject.add(@broadcaster_1, standard_delivery)
      expect(subject.items.length).to eq(1)
    end

     it 'increases delivery order count', :focus => true do
       delivery = spy('Delivery')
       subject.add(@broadcaster_1, delivery)
       expect(delivery).to have_received(:increase_counter)
     end

    it 'adds current delivery discount saved to total delivery discount' do
      subject.add(@broadcaster_2, express_delivery)
      subject.add(@broadcaster_3, express_delivery)
      expect(subject.total_delivery_discount).to eq(10)
    end
  end

  before(:each) do
    @broadcaster_1 = Broadcaster.new(1, 'Viacom')
    @broadcaster_2 = Broadcaster.new(2, 'Disney')
    @broadcaster_3 = Broadcaster.new(3, 'Discovery')
  end

  context 'when undoing last order' do
    it 'removes it from the array' do
      subject.add(@broadcaster_1, standard_delivery)
      subject.add(@broadcaster_1, standard_delivery)
      subject.remove
      expect(subject.items.length).to eq(1)
    end

    it 'decreases delivery order count', :focus => true do
      delivery = spy('Delivery')
      subject.add(@broadcaster_1, delivery)
      subject.remove
      expect(delivery).to have_received(:decrease_counter)
    end

    it 'recalculates correct delivery discount' do
      subject.add(@broadcaster_2, express_delivery)
      subject.add(@broadcaster_3, express_delivery)
      subject.remove
      expect(subject.total_cost).to eq(20.00)
    end
  end

  context 'with items' do
    it 'returns the total cost of all items' do
      subject.add(@broadcaster_1, standard_delivery)
      subject.add(@broadcaster_2, express_delivery)
      expect(subject.total_cost).to eq(30.00)
    end
  end

  context 'with eligible discount' do
    it 'returns the correct discount for delivery' do
      subject.add(@broadcaster_2, express_delivery)
      subject.add(@broadcaster_3, express_delivery)
      expect(subject.total_cost).to eq(30.00)
    end

    it 'returns the correct discount for 10% off total' do
      subject.add(@broadcaster_1, standard_delivery)
      subject.add(@broadcaster_2, express_delivery)
      subject.add(@broadcaster_3, express_delivery)
      expect(subject.total_cost).to eq(36.00)
    end
  end

  context 'when printing' do
    it 'calls the output method in the print class' do
      printing = spy("Printing")
      subject.send_to_printer(printing)
      expect(printing).to have_received(:output)
    end
  end
end
