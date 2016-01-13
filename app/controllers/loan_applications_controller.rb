class LoanApplicationsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new , :create]

  def index
    if current_user
      @loan_apps = current_user.loan_applications
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @loan_app = current_user.loan_applications.find(params[:id])
    respond_to do |format|
      format.html { redirect_to loan_application_path(@loan_app, format: "pdf") } # if js is disabled on a browser, download pdf
      format.js   # in case mobile does not respond
      format.pdf do
        pdf = LoanApplicationPdf.new(@loan_app, view_context)  # add view_context to use Rails view helpers in pdf class
        send_data pdf.render, filename: "loan_application_#{@loan_app.id}.pdf",
                              type: "application/pdf"
      end
    end
  end

  def new
    @loan_app = current_user.loan_applications.build
  end

  def create
    @loan_app = current_user.loan_applications.create(loan_params)  # ajax will take care of displaying the errors
    @loan_apps = current_user.loan_applications   # for ajax to render all loan apps

    if @loan_app.valid? # if @loan_app is not valid, it won't create the PDF or create the database
      pdf = LoanApplicationPdf.new(@loan_app, view_context)  # add view_context to use Rails view helpers in pdf class
      @loan_app.generate(pdf)
    end
  end

  private
    def loan_params
      params.require(:loan_application).permit(:amount, :down_payment, :interest)
    end
end
