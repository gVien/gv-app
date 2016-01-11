require 'rails_helper'

RSpec.feature "User Sessions", type: :feature do
  before { FactoryGirl.create(:user) }

  scenario 'with valid credentials and then sign out' do
    visit new_user_session_path
    fill_in 'Email', with: "gai@gai.com"
    fill_in 'Password', with: "12345678"
    # click_on 'Log In'   # apparently, there are 2 "Log In" in main page which confuses Capybara (!!!)
    page.find('.btn.btn-primary').click

    expect(page).to have_content('Signed in successfully.')
  end
end
