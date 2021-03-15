# frozen_string_literal: true

require_relative "../../config/environment"

# Any benchmarking setup goes here...
ActiveRecord::Base.transaction do
  cart = Cart.create!
  products = 1_000.times.map { Product.create!(name: "x", price: 10.00) }
  products.each { |product| cart.items.create!(product: product, amount: 1) }

  def query(cart)
    cart.items.map { |item| item.product }
  end

  Benchmark.ips do |x|
    x.report("before") { query(Cart.last) }
    x.report("after") { query(Cart.includes(items: :product).last) }

    x.compare!
  end

  raise ActiveRecord::Rollback
end
