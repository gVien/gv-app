require 'rails_helper'

RSpec.feature "UsersSignups", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  scenario "user visit a signup page and sign up for a VALID account" do
    expect do
      sign_up_user            # see `support/session_helpers.rb` for method details
    end.to change(User, :count).by(1)
    expect(page).to_not have_css("div#error_explanation")
    expect(page).to_not have_css("div.field_with_errors")
    expect(page).to have_content("Welcome! You have signed up successfully.")

  end

  scenario "user signed up for an account that already exists" do
    sign_up_user(email: user.email)
    expect(page).to have_css("div.field_with_errors")
    expect(page).to have_content("Email has already been taken")
  end

  scenario "user signed up for an account with valid email but mismatch passwords or too short" do
    sign_up_user({ first_name: "another",
                   last_name: "user",
                   email: "another@user.com",
                   password: "short",
                   password_confirmation: "no_match_and_long" })
    expect(page).to have_css("div.field_with_errors")
    expect(page).to have_content("Password is too short (minimum is 8 characters)")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
