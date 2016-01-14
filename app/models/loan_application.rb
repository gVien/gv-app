class LoanApplication < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :asc) } # order all loan app asc

  extend FriendlyId
  friendly_id :doc_id, use: :slugged

  has_attached_file :document
  validates_attachment :document, content_type: { content_type: "application/pdf" }


  before_create :create_doc_id
  validates :amount, :down_payment, :interest, :user_id, presence: true, numericality: { greater_than: 0 }


  # generate pdf and update paperclip attachment
  def generate(pdf)
    file = StringIO.new(pdf.render)   # this mimic a file upload
    file.class.class_eval { attr_accessor :original_filename, :content_type }
    file.original_filename = "loan_application_#{id}.pdf"
    file.content_type = "application/pdf"
    update_attributes(document: file)
  end

  private
    def create_doc_id
      self.doc_id = SecureRandom.urlsafe_base64(6)
    end
end
