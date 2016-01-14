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
    @loan_app = current_user.loan_applications.friendly.find(params[:id])
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
