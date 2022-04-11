class Person < ApplicationRecord
  has_many :emitted_invoices, foreign_key: :emitter_id,
                              inverse_of: :emitter,
                              class_name: 'Invoice',
                              dependent: :destroy
  has_many :received_invoices, foreign_key: :receiver_id,
                               inverse_of: :receiver,
                               class_name: 'Invoice',
                               dependent: :destroy

  validates :uuid, :name, presence: true
  validates_uniqueness_of :uuid
end
