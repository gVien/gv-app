require 'rails_helper'

RSpec.feature "CreateLoanApplications", type: :feature do
  # test procedures
  # there will be three scenarios,
    # 1. a user apply for an invalid loans (some fields have not been filled out)
    # 2. a user apply for a valid loans (all fields are present)
    # 3. loans create from user A cannot be seen by user B and vice versa

  # scenario 1: a user apply for an invalid loans
  # a user logs in
  # a user can create a new loan application by clicking on "Apply for a New Loan" link
  # a user does not filled out the form and click "Process My Loan" link inside the modal
  # verify that the errors messages display inside the modal
  scenario "a user apply for an invalid loans", js: true do
    sign_in_default_user                # support/session_helpers.rb
    click_link "Apply for a New Loan"
    click_button "Process My Loan"
    expect(page).to have_content("Amount can't be blank")
    expect(page).to have_content("Amount is not a number")
    expect(page).to have_content("Down payment can't be blank")
    expect(page).to have_content("Down payment is not a number")
    expect(page).to have_content("Interest can't be blank")
    expect(page).to have_content("Interest is not a number")
  end

  # scenario 2: a user apply for an VALID loans and can view new loan
  # a user logs in
  # a user can create a new loan application by clicking on "Apply a New Loan" link
  # fill in the `amount`, `down payment`, `interest`
  # click "Process My Loan" link inside the modal
  # verify THERE ARE NO errors messages inside the modal
  # verify the modal disappears (`display: none` in the modal)
  scenario "a user apply for a VALID loan", js: true do
    user = FactoryGirl.create(:user)
    sign_in_with(user.email, user.password)            # support/session_helpers.rb
    click_link "Apply for a New Loan"
    fill_in "Amount", with: "123456"
    fill_in "Down payment", with: "1234"
    fill_in "Interest", with: "5"
    click_button "Process My Loan"
    expect(page).to have_content("Amount: $123456")
    expect(page).to have_content("Down Payment: $1234")
    expect(page).to have_content("Interest: 5.0%")
    expect(page).to have_content("View PDF")
  end

  # scenario 3: loans create from user A cannot be seen by user B and vice versa
  # before create users (at least 2) and create loan app for each user
  # log in as User A
  # verify the loan app info is exists in User A page
  # verify the loan app info of User B is not on the page
  before do
    user_a = User.create( first_name: "user",
                          last_name: "A",
                          email: "userA@user.com",
                          password: "12345678",
                          password_confirmation: "12345678" )
    user_a.loan_applications.create(amount: 10_000, down_payment: 2_000, interest: 10)
    user_b = User.create( first_name: "user",
                          last_name: "B",
                          email: "userB@user.com",
                          password: "12345678",
                          password_confirmation: "12345678" )
    loab_b = user_b.loan_applications.create(amount: 50_000, down_payment: 10_000, interest: 2)
  end

  scenario "loans created from user A cannot be seen by user B", js: true do
    sign_in_with("userA@user.com", "12345678")

    expect(page).to have_content("Amount: $10000")
    expect(page).to have_content("Down Payment: $2000")
    expect(page).to have_content("Interest: 10.0%")

   # user A cannot see user B loan info
    expect(page).to_not have_content("Amount: $50000")
    expect(page).to_not have_content("Down Payment: $10000")
    expect(page).to_not have_content("Interest: 2.0%")
  end
end
