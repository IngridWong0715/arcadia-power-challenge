require 'csv'

namespace :import do
  desc "Import users from csv"
  task users: :environment do
    path = Rails.root.join("users.csv")
    CSV.foreach(path, headers: true) do |row|
      row_without_id = row.to_hash
      row_without_id.delete("id")
      User.create!(row_without_id)
    end
  end

  desc "Import accounts from csv"
  task accounts: :environment do
    path = Rails.root.join("accounts.csv")
    CSV.foreach(path, headers: true) do |row|
      row_without_id = row.to_hash
      row_without_id.delete("id")
      row_without_id["category"] = row_without_id.delete("type")
      Account.create!(row_without_id)
    end
  end

  desc "Import bills from csv"
  task bills: :environment do
    path = Rails.root.join("bills.csv")
    CSV.foreach(path, headers: true) do |row|
      row_without_id = row.to_hash
      row_without_id.delete("id")
      Bill.create!(row_without_id)
    end
  end
end
