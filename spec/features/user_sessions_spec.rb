require 'rails_helper'

RSpec.feature "User Sessions", type: :feature do
  scenario 'user sign in with VALID credentials and then signout' do
    # see support/session_helpers for detail of this method
    sign_in_default_user

    expect(page).to have_content('Signed in successfully.')

    click_link "Log out"
    expect(page).to have_content("Signed out successfully.")
  end

  scenario 'user sign in with INVALID credentials' do
    # see support/session_helpers for detail of this method
    sign_in_with("invalid@user.com", "invalidpass")

    expect(page).to have_content('Invalid email or password.')
  end
end
