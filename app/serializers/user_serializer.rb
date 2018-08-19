class UserSerializer < ActiveModel::Serializer
  has_many :accounts
  attributes :id, :first_name, :last_name, :email, :status
end
