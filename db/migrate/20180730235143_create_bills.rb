class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.date :start_date
      t.date :end_date
      t.integer :usage
      t.float :charges
      t.string :status
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
