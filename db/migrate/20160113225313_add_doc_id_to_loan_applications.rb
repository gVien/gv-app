class AddDocIdToLoanApplications < ActiveRecord::Migration
  def change
    add_column :loan_applications, :doc_id, :string
    add_index :loan_applications, :doc_id, unique: true
  end
end
