class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :accounts
  has_many :bills, through: :accounts

  validates :status, presence: true
  validates :status, inclusion: { in: %w(active inactive),
   message: "%{value} must be active or inactive" }


end
