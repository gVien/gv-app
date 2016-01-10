FactoryGirl.define do
  factory :loan_application do
    amount 100_000
    down_payment 10_000
    interest 1.5
    user
  end
end
