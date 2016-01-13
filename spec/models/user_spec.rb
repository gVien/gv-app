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

    it "is invalid without a first name" do
      expect(build(:user, first_name: nil)).to_not be_valid
    end

    it "is invalid when first name is over 50 chars long" do
      expect(build(:user, first_name: "a" * 51)).to_not be_valid
    end

    it "is invalid without a last name" do
      expect(build(:user, last_name: nil)).to_not be_valid
    end

    it "is invalid when last name is over 50 chars long" do
      expect(build(:user, last_name: "a" * 51)).to_not be_valid
    end
  end
end
