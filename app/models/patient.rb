class Patient < ApplicationRecord
  has_many :intakes
  has_many :contact_methods

  before_validation :normalize_email

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
