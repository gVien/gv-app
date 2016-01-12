class AddAttachmentDocumentToLoanApplications < ActiveRecord::Migration
  def change
      add_attachment :loan_applications, :document
  end
end
