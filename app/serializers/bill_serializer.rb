class BillSerializer < ActiveModel::Serializer
  belongs_to :account
  attributes :start_date, :end_date, :usage, :charges, :status
end
