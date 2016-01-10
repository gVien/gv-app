class LoanApplication < ActiveRecord::Base
  belongs_to :user

  validates :amount, :down_payment, :interest, presence: true, numericality: { greater_than: 0 }
end
