class CreateLoanApplications < ActiveRecord::Migration
  def change
    create_table :loan_applications do |t|
      t.integer :amount   # can be decimal too but will ignore it
      t.integer :down_payment
      t.decimal :interest #make sense to have decimal here
      # t.references => t.string :user_id
      t.references  :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
