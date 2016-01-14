module LoanApplicationsHelper
  # shows loan_app id when legacy user does not have doc_id
  # otherwise shows doc_id (upcase) if it exists
  def show_doc_id(loan_app)
    loan_app.doc_id.nil? ? loan_app.id : loan_app.doc_id.upcase
  end
end
