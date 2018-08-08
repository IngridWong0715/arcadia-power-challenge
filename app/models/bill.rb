class Bill < ApplicationRecord
  belongs_to :account

  validates :start_date, :end_date, :usage, :charges, :status, presence: true
  validates :usage, :charges, numericality: true
  validates :status, inclusion: { in: %w(paid unpaid),
            message: "%{value} must be paid or unpaid" }

 scope :paid, -> { where(status: 'paid')}
 scope :unpaid, -> { where(status: 'unpaid')}

 def self.twelve_month_averages
   averages = {}
   for i in 0..12 do
     month = (Date.today - i.month).month
     year = (Date.today - i.month).year
     month_year = (Date.today - i.month).strftime("%B %Y")
     averages[month_year] = monthly_average_usage(month, year)
   end
   averages

 end

 def self.monthly_average_usage(month, year = Date.today.year)
    by_month(month, year).average(:usage)
 end

 def self.by_month(month, year = Date.today.year)
   where("cast(strftime('%Y', start_date) as int) = ? AND cast(strftime('%m', start_date) as int) = ? ", year, month)
 end

end
