class Cart::Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :amount, numericality: { greater_than: 0 }
end
