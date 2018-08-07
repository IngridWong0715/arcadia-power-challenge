class Account < ApplicationRecord
  belongs_to :user
  has_many :bills
  validates :utility, :category, :account_number, presence: true
  validates :category, inclusion: { in: %w(residential commercial),
   message: "%{value} must be residential or commercial" }
end
