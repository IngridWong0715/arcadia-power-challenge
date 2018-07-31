class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :utility
      t.string :category
      t.string :account_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
