class User < ApplicationRecord
  extend CalculatePercentage
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :accounts
  has_many :bills, through: :accounts

  validates :status, presence: true
  validates :status, inclusion: { in: %w(active inactive),
   message: "%{value} must be active or inactive" }

  scope :active, -> { where(status: 'active')}
  scope :inactive, -> { where(status: 'inactive')}

  def self.active_percentage
    percentage(active.count.to_f, count.to_f)
  end

  def self.inactive_percentage
    percentage(inactive.count.to_f, count.to_f)
  end





end
