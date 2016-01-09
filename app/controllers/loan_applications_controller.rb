class LoanApplicationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    if current_user
      @loan_apps = current_user.loan_applications
    else
      redirect_to new_user_session_path
    end
  end

  def new
    @loan_app = current_user.loan_applications.build
  end

  def create
    @loan_app = current_user.loan_applications.create(loan_params)  # ajax will take care of displaying the errors
    @loan_apps = current_user.loan_applications   # for ajax to render all loan apps

    # this works without Ajax but combining the two creates incompatibility (will fix this sometime later)
    # remember to set `config.action_view.embed_authenticity_token_in_remote_forms = true` in the application.rb in config folder to allow people with no JS (e.g. noscript in Firefox) to use form
    #
    # if @loan_app.save
    #   # @loan_apps = current_user.loan_applications
    #   redirect_to root_path
    # else
    #   render "new"
    # end
  end

  private
    def loan_params
      params.require(:loan_application).permit(:amount, :down_payment, :interest)
    end
end
