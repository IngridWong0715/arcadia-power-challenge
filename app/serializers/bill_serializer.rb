class BillSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :usage, :charges, :status
end
