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

 # NOT WORKING:
 # BY_ACCOUNT_TYPE does not take into account bills_by_month
 def self.monthly_usage_by_account_type(account_type, month, year = Date.today.year)
   bills_by_month= by_month(month, year)
   res = bills_by_month.by_account_type(account_type)

 end

 def self.by_account_type(type)
   # get all bills whose account is of type
   p = ActiveRecord::Base.establish_connection
   c = p.connection
   results = c.execute("
     select usage
     from bills
     inner join accounts on bills.account_id = accounts.id
     where accounts.category = 'commercial'")

     results
 end

end
