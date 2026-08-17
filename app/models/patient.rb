class Patient < ApplicationRecord
  has_many :intakes
  has_many :contact_methods

  before_validation :normalize_email
  validates :date_of_birth, presence: true

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
