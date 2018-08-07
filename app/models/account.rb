class Account < ApplicationRecord
  belongs_to :user
  has_many :bills
  validates :utility, :category, :account_number, presence: true
  validates :category, inclusion: { in: %w(residential commercial),
   message: "%{value} must be residential or commercial" }

  scope :residential, -> { where(category: 'residential')}
  scope :commercial, -> { where(category: 'commercial')}

  def self.residential_type_percentage
    percentage(residential.count.to_f, count.to_f)
  end

  def self.commercial_type_percentage
    percentage(commercial.count.to_f, count.to_f)
  end
end
