class LoanApplication < ActiveRecord::Base
  belongs_to :user
  has_attached_file :document
  validates_attachment :document, content_type: { content_type: "application/pdf" }

  validates :amount, :down_payment, :interest, presence: true, numericality: { greater_than: 0 }
end
