require 'rails_helper'

RSpec.describe LoanApplicationsController, type: :controller do
  describe "GET #index with signed in user" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in :user, user }
    before { get :index }

    # test procedures
    # 1. after logging in, it should render http status (200) & success status
    # 2. after logging in, it should render the index page
    # 3. after logging in, it should display all the loans application
    describe "responds and rendering of #index" do
      it "responds successfully with an HTTP 200 status code" do
        # @request.env['devise.mapping'] = Devise.mappings[:user]   # not required
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the index page" do
        expect(response).to render_template("index")
      end
    end

    # Got these errors: `Error: Permission denied @ dir_s_mkdir - /loan_applications`
    # see http://stackoverflow.com/questions/11864175/paperclip-errnoeacces-permission-denied-system
    describe "create loan application with Ajax" do
      it "should increment the loan application count" do
        # post :create, loan_application: attributes_for(:loan_application) # can't do this since it's an ajax call
        expect do
          xhr :post, :create, loan_application: attributes_for(:loan_application)
        end.to change(LoanApplication, :count).by(1)
      end

      it "should respond with success" do
        xhr :post,  :create, loan_application: attributes_for(:loan_application)
        expect(response).to be_success
      end
    end
  end

  describe "GET #index without signed in" do
    before { get :index }

    it "should redirect to login page if user is not signed in" do
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should not increment the loan application count" do
      # post :create, loan_application: attributes_for(:loan_application) # can't do this since it's an ajax call
      expect do
        xhr :post, :create, loan_application: attributes_for(:loan_application)
      end.to change(LoanApplication, :count).by(0)
    end
  end
end
