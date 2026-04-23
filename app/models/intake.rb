class Intake < ApplicationRecord
  validates :full_name, presence: true
  validates :email, presence: true
  validates :reason_for_visit, presence: true
  validates :urgency, presence: true
end
