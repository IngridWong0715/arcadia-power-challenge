class Admin::StatsController < ApplicationController
  def monthly_average_usage
    average = Bill.monthly_average_usage(params[:month], params[:year])
    render json: {"Average for #{params[:month]}  #{params[:year]}": average}
  end

  def user_activity
    total_user_count = User.count
    active_percentage = User.active_percentage
    inactive_percentage = User.inactive_percentage
    render json: {"Total User Count:": total_user_count, "Active User:": active_percentage, "Inactive User:": inactive_percentage  }
  end

  def account_type_breakdown
  end




  def annual_report
  end


end
