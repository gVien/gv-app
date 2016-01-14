require 'rails_helper'

RSpec.describe LoanApplication, type: :model do
  describe "validity of loans application parameters" do
    let(:loan) {FactoryGirl.build(:loan_application)} # loan app belongs to user_id 1

    it "is valid when all loan application parameters are present" do
      # use this
      # user = User.create!(email: "gai@gai.com", password: "12345678", password_confirmation: "12345678")
        # or this using FactoryGirl (or create one in the FactoryGirl folder)
        # user = FactoryGirl.create(:user, email: "hi@gai.com", password: "12345678", password_confirmation: "12345678")
        # loan = user.loan_applications.build(amount: 100, down_payment: 500, interest: 1.5)
      # or this
      # loan = LoanApplication.new(amount: 100, down_payment: 500, interest: 1.5)
      # loan = build(:user).build(:loan_application)

      # loan = FactoryGirl.build(:loan_application) # loan app belongs to user_id 1
      expect(loan).to be_valid
    end

    it "is invalid when AMOUNT is nil, 0, or negative float number" do
      invalid_params = [0, nil, -10]
      invalid_params.each do |invalid_param|
        loan.amount = invalid_param
        expect(loan).to_not be_valid
      end
    end

    it "is invalid when DOWN_PAYMENT is nil, 0, or negative float number" do
      invalid_params = [0, nil, -10_000]
      invalid_params.each do |invalid_param|
        loan.down_payment = invalid_param
        expect(loan).to_not be_valid
      end
    end

    it "is invalid when INTEREST RATE is nil, 0, or negative float number" do
      invalid_params = [0, nil, -1.5]
      invalid_params.each do |invalid_param|
        loan.interest = invalid_param
        expect(loan).to_not be_valid
      end
    end

    it "is invalid when user_id is not present" do
      loan.user_id = nil
      expect(loan).to_not be_valid
    end
  end

  describe "loan_applications should be deleted if user is deleted" do
    let(:loan) {FactoryGirl.create(:loan_application)}

    it "loan should be nil when user is deleted" do
      loan.user.destroy
      expect(LoanApplication.find_by(id: loan.id)).to be_nil
    end
  end
end
