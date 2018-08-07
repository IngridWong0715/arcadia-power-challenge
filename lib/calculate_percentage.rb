module CalculatePercentage
  def percentage(type_count, total_count)
    "#{type_count.to_f / total_count.to_f * 100.00}%"
  end
end
