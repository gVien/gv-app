class LoanApplicationPdf < Prawn::Document
  def initialize(loan_app, view)
    super()
    @loan_app = loan_app
    @view = view  # to use the Rails view helpers
    loan_intro
    line_items
  end

  def loan_intro
    text "Loan Document \##{@loan_app.id}", size: 25, style: :bold, color: "009BFF"
    text "Thank you for choosing Loanify as your loaning needs. Below is a summary of your loan information that you can save it for your record."
  end

  def line_items
    move_down 15
    table line_items_rows do
      row(0).font_style = :bold
      row(0).background_color = "40B173"
      row(1).align = :right
    end
    loan_payment
    move_down 15
    loan_thank_you
  end

  def line_items_rows
    [["Amount", "Down Payment", "Interest"], ["#{number_to_currency(@loan_app.amount)}", "#{number_to_currency(@loan_app.down_payment)}", "#{number_to_percentage(@loan_app.interest)}"]]
  end

  def loan_payment
    move_down 15
    first_year_interest = (@loan_app.amount - @loan_app.down_payment) * @loan_app.interest / 100
    text "Your payment for the first year is #{number_to_currency(first_year_interest)} or #{number_to_currency(first_year_interest.to_f / 12)} monthly."
  end

  def loan_thank_you
    text "We hope to do more business with you in the future."
    move_down 15
    text "Sincerely, \n\n The Loanify Team"
  end

  # using the view helper from Rails to convert number to currency
  def number_to_currency(num)
    @view.number_to_currency(num)
  end

  # using the view helper from Rails to convert number to percentage
  def number_to_percentage(num)
    @view.number_to_percentage(num, precision: 2)
  end
end