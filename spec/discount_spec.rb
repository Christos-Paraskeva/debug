require './models/discount'

describe Discount do
  subject { Discount.new }

  context 'when conditions are met' do
    it 'applies discount to delivery' do
      delivery = double("Delivery")

      allow(delivery).to receive_messages(
        :discount => {
          discount_eligibility: 2,
          discount_price: 15
        },
        :order_count => 2)
      expect(subject.calculate_delivery(delivery)).to eq(15)
    end

    it 'applies 10% discount to total' do
      order = double("Order")
      allow(order).to receive(:total_cost).and_return(40)
      expect(subject.calculate_total_cost(order.total_cost)).to eq(36)
    end
  end
end
