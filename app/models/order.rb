class Order < ApplicationRecord
  validates :token, :first_name, :last_name, :address, presence: true
  validates :token, uniqueness: true
end
