class LoanApplicationPdf < Prawn::Document
  def initialize(loan_app)
    super()
    @loan_app = loan_app
    loan_intro
    line_items
  end

  def loan_intro
    text "Loan Document \##{@loan_app.id}", size: 25, style: :bold, color: "009BFF"
    text "Thank you for choosing Loanify as your loaning needs. Below is a summary of your loan information that you can save it for your record."
  end

  def line_items
    move_down 25
    table line_items_rows do
      row(0).front_style = :bold
      row(1).align = :right
    end
    move_down 25
    loan_thank_you
  end

  def line_items_rows
    [["Amount", "Down Payment", "Interest"], ["#{@loan_app.amount}", "#{@loan_app.down_payment}", "#{@loan_app.interest}"]]
  end

  def loan_thank_you
    text "We hope to do more business with you in the future."
    move_down 15
    text "Sincerely, \n\n The Loanify Team"
  end
end