class Delivery
  attr_accessor :name, :current_price, :discount, :order_count

  def initialize(name, original_price, discount_eligibility = false, discount_price = original_price)
    self.name = name
    self.discount = {
      original_price: original_price,
      discount_eligibility: discount_eligibility,
      discount_price: discount_price
    }
    self.current_price = discount[:original_price]
    self.order_count = 0
  end

  def increase_counter
    self.order_count += 1
  end

  def decrease_counter
    self.order_count -= 1
  end

  def calculate_total_discount
    (order_count * discount[:original_price]) - (order_count * current_price)
  end
end
