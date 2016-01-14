module LoanApplicationsHelper
  def show_doc_id(loan_app)
    loan_app.doc_id || loan_app.id
  end
end
