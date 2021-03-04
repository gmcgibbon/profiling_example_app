class Order < ApplicationRecord
  belongs_to :cart

  validates :token, :first_name, :last_name, :address, presence: true
  validates :token, uniqueness: true
end
