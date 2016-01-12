require 'rails_helper'

RSpec.feature "UsersSignups", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  scenario "user visit a signup page and sign up for a VALID account" do
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: "new@user.com"
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "12345678"
    page.find('.btn.btn-primary').click
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario "user signed up for an account that already exists" do
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: user.email
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "12345678"
    page.find('.btn.btn-primary').click
    expect(page).to have_content("Email has already been taken")
  end

  scenario "user signed up for an account with valid email but mismatch passwords or too short" do
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: "another@user.com"
    fill_in "Password", with: "12345"
    fill_in "Password confirmation", with: "12345678232"
    page.find('.btn.btn-primary').click
    expect(page).to have_content("Password is too short (minimum is 8 characters)")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
