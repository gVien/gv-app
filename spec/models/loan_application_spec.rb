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

    it "is invalid without amount" do
      loan.amount = nil
      expect(loan).to_not be_valid
    end

    it "is invalid when amount is negative integer" do
      loan.amount = -10
      expect(loan).to_not be_valid
    end

    it "is invalid without down_payment" do
      loan.down_payment = nil
      expect(loan).to_not be_valid
    end

    it "is invalid when down_payment is negative integer" do
      loan.down_payment = -10_000
      expect(loan).to_not be_valid
    end

    it "is invalid without interest" do
      loan.interest = nil
      expect(loan).to_not be_valid
    end

    it "is invalid when interest is negative float number" do
      loan.interest = -1.5
      expect(loan).to_not be_valid
    end

  end
end
