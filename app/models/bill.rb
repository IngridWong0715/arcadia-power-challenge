class Bill < ApplicationRecord
  belongs_to :account

  validates :start_date, :end_date, :usage, :charges, :status, presence: true
  validates :usage, :charges, numericality: true
  validates :status, inclusion: { in: %w(paid unpaid),
            message: "%{value} must be paid or unpaid" }

 scope :paid, -> { where(status: 'paid')}
 scope :unpaid, -> { where(status: 'unpaid')}

 def self.monthly_average_usage(month, year = Date.today.year)
    by_month(month, year).average(:usage)
 end

 def self.by_month(month, year = Date.today.year)
   where("cast(strftime('%Y', start_date) as int) = ? AND cast(strftime('%m', start_date) as int) = ? ", year, month)
 end
end
