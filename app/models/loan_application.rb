class LoanApplication < ActiveRecord::Base
  belongs_to :user
  has_attached_file :document
  validates_attachment :document, content_type: { content_type: "application/pdf" }

  validates :amount, :down_payment, :interest, presence: true, numericality: { greater_than: 0 }

  # generate pdf and update paperclip attachment
  def generate_pdf(loan_app)
    pdf = LoanApplicationPdf.new(loan_app, view_context)  # add view_context to use Rails view helpers in pdf class
    file = StringIO.new(pdf.render)   # this mimic a file upload
    file.class.class_eval { attr_accessor :original_filename, :content_type }
    file.original_filename = "loan_application_#{loan_app.id}.pdf"
    file.content_type = "application/pdf"
    update_attributes(document: file)
  end
end
