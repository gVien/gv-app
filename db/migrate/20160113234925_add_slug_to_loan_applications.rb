class AddSlugToLoanApplications < ActiveRecord::Migration
  def change
    add_column :loan_applications, :slug, :string
    add_index :loan_applications, :slug, unique: true
  end
end
