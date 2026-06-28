class Intake < ApplicationRecord
  belongs_to :patient, optional: true
  validates :full_name, presence: true
  validates :email, presence: true
  validates :reason_for_visit, presence: true
  validates :urgency, presence: true
  validates :phone, presence: true
  validates :phone, format: { with: /\A\d{10,15}\z/, message: "must be a valid phone number" }
end
