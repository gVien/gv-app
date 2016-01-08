require 'rails_helper'

RSpec.describe User, type: :model do
  # Devise already has these tests for users covered, but redoing it!

  describe "validity of the users model" do
    it "has a valid user factory" do
      expect(build(:user)).to be_valid
    end

    it "is invalid without an email" do
      expect(build(:user, email: nil)).to_not be_valid
    end

    it "is invalid without a password" do
      expect(build(:user, password: nil)).to_not be_valid
    end
  end
end
