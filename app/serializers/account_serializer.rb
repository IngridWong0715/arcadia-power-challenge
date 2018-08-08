class AccountSerializer < ActiveModel::Serializer
  attributes :id, :utility, :category, :account_number
end
