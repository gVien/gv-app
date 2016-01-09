class LoanApplicationsController < ApplicationController
  def index
    @loan_apps = current_user.loan_applications
  end

  def new
    @loan_app = current_user.loan_applications.build
  end

  def create
  end
end
