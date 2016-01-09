class LoanApplicationsController < ApplicationController
  def index
    @loan_apps = current_user.loan_applications
  end

  def new
  end

  def create
  end
end
