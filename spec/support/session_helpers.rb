# spec/support files are for modules and configuration to be use in you specs
module SessionHelpers
  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    # apparently, there are 2 "Log In" in main page which confuses Capybara (!!!)
    page.find('.btn.btn-primary').click
  end

  # this is not to be confused with the `sign_in` helper method from Devise (included inside rails_helper.rb)
  def sign_in_default_user
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    # apparently, there are 2 "Log In" in main page which confuses Capybara (!!!)
    page.find('.btn.btn-primary').click
  end
end