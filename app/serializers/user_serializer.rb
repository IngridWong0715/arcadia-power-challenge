class UserSerializer < ActiveModel::Serializer
  has_many :accounts
  attributes :first_name, :last_name, :full_name, :email, :status

  def full_name
    object.first_name + object.last_name
  end
end
