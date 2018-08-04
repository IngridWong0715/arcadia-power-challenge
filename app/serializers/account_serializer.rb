class AccountSerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :bills
  attributes :utility, :category, :account_number
end
