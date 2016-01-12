class LoanApplication < ActiveRecord::Base
  belongs_to :user
  has_attached_file :document
  validates_attachment :document, content_type: { content_type: "application/pdf" }

  validates :amount, :down_payment, :interest, :user_id, presence: true, numericality: { greater_than: 0 }

  # generate pdf and update paperclip attachment
  def generate(pdf)
    file = StringIO.new(pdf.render)   # this mimic a file upload
    file.class.class_eval { attr_accessor :original_filename, :content_type }
    file.original_filename = "loan_application_#{id}.pdf"
    file.content_type = "application/pdf"
    update_attributes(document: file)
  end
end
