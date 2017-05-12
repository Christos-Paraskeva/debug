require './models/delivery'

describe Delivery do

  before(:each) do
    @delivery = Delivery.new('standard_delivery', 10)
  end

  context 'when initialized' do
    it 'has a name' do
      expect(@delivery.name).to eq('standard_delivery')
    end

    it 'has an original price within a hash' do
      expect(@delivery.discount[:original_price]).to eq(10)
    end

    it 'has a default discount_eligibility parameter within a hash' do
      expect(@delivery.discount[:discount_eligibility]).to eq(false)
    end

    it 'has a default discount_price parameter within a hash' do
      expect(@delivery.discount[:discount_price]).to eq(@delivery.discount[:original_price])
    end

    it 'current price is same as original price by default' do
      expect(@delivery.discount[:discount_price]).to eq(@delivery.discount[:original_price])
    end

    it 'has a counter' do
      expect(@delivery.order_count).to eq(0)
    end
  end

  context 'counter' do
    before(:each) do
      @delivery.order_count = 5
    end

    it 'can be increased' do
      @delivery.increase_counter
      expect(@delivery.order_count).to eq(6)
    end

    it 'can be decreased' do
      @delivery.decrease_counter
      expect(@delivery.order_count).to eq(4)
    end
  end

  # context 'discount' do
  #   it 'can calculate the total delivery discount of whole order' do
  #     @delivery.discount[:original_price] = 20
  #     @delivery.discount[:discount_eligibility] = 2
  #     @delivery.current_price = 15
  #     @delivery.order_count = 5
  #     expect(@delivery.calculate_total_discount).to eq(25)
  #   end
  # end
end
