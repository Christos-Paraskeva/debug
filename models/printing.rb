class Printing
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :order_information

  def initialize
    @order_information = []
  end

  def output(total_cost, items, material)
    [].tap do |order_information|
      order_information << "Order for #{material.identifier}:"
      order_information << print_columns
      order_information << print_output_separator
      order_information << print_information(items)
      order_information << print_output_separator
      order_information << "Total: $#{total_cost}"
    end.join("\n")
  end

  private

  def print_information(items)
    items.each_with_index do |(broadcaster, delivery), index|
      order_information << [
        broadcaster.name.ljust(COLUMNS[:broadcaster]),
        delivery.name.to_s.ljust(COLUMNS[:delivery]),
        ("$#{delivery.current_price}").ljust(COLUMNS[:price])
      ].join(' | ')
    end
    order_information
  end

  def print_columns
    COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
  end

  def print_output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
