class Bill < ApplicationRecord
  belongs_to :account

  scope :paid, -> { where(status: 'paid')}
  scope :unpaid, -> { where(status: 'unpaid')}
end
