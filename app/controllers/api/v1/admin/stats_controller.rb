module Api
  module V1
    class Admin::StatsController < AdminController
      def monthly_average_usage
        average = Bill.monthly_average_usage(params[:month], params[:year])
        render json: {"Average for #{params[:month]}  #{params[:year]}": average}
      end

      def user_activity
        total_user_count = User.count
        active_percentage = User.active_percentage
        inactive_percentage = User.inactive_percentage
        render json: {
          "Total User Count:": total_user_count,
          "Active User:": active_percentage,
          "Inactive User:": inactive_percentage
        }
      end

      def account_type_breakdown
        residential_count = Account.residential.count
        residential_percentage = Account.residential_type_percentage
        commercial_count = Account.commercial.count
        commercial_percentage = Account.commercial_type_percentage

        render json: {
          "Total Residential Accounts:": residential_count,
          "Residential Percentage:": residential_percentage,
          "Total Commercial Accounts:": commercial_count,
          "Residential Percentage:": residential_percentage
        }
      end
    end
  end
end
