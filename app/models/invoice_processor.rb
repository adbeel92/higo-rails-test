class InvoiceProcessor < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :invoice, optional: true

  has_one_attached :file
  has_one :file_attachment, -> { where(name: 'file') }, class_name: 'ActiveStorage::Attachment',
          as: :record, inverse_of: :record, dependent: :destroy
  has_one :file_blob, through: :file_attachment, class_name: 'ActiveStorage::Blob',
          source: :blob

  validates :status, :file_type, presence: true

  enum file_type: {
    xml: 'xml'
  }

  aasm column: :status do
    state :pending, initial: true
    state :running, :uploaded, :error

    event :run do
      transitions from: [:pending, :error, :running], to: :running
    end

    event :complete do
      transitions from: :running, to: :uploaded
    end

    event :to_retry do
      transitions from: [:pending, :running, :uploaded, :error], to: :error
    end
  end
end
