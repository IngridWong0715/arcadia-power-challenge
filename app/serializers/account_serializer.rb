class AccountSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :utility, :category, :account_number
end
