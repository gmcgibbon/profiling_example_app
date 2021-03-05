class Cart < ApplicationRecord
  has_many :items, class_name: "Cart::Item"

  accepts_nested_attributes_for :items, allow_destroy: true

  def price
    items.map(&:price).sum
  end
end
