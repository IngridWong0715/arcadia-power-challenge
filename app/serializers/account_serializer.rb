class AccountSerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :bills
  attributes :id, :utility, :category, :account_number
end
