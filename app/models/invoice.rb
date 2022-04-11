class Invoice < ApplicationRecord
  belongs_to :emitter, class_name: 'Person'
  belongs_to :receiver, class_name: 'Person'
  belongs_to :user

  validates :uuid, :amount, presence: true
  validates_uniqueness_of :uuid, case_insensitive: false
end
