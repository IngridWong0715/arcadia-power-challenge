class BillSerializer < ActiveModel::Serializer
  belongs_to :account

  attributes :id, :start_date, :end_date, :usage, :charges, :status

  def user
  end
end
