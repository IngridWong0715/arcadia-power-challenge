class Account < ApplicationRecord
  extend CalculatePercentage

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

  def prev_twelve_bills_usage
    bills = {}
    for i in 0..12 do
      month = (Date.today - i.month).month
      year = (Date.today - i.month).year
      month_year = (Date.today - i.month).strftime("%B %Y")
      bill = self.bills.by_month(month, year).first
      bills[month_year] = bill == nil ? nil : bill.usage
    end
    bills
  end
end
