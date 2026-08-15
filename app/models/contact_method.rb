class ContactMethod < ApplicationRecord
  belongs_to :patient

  validates :kind,
            inclusion: { in: %w[email mobile_phone home_phone work_phone] }
  validates :value, presence: true
  validates :effective_from, presence: true
  validate :effective_to_cannot_be_before_effective_from

  private

  def effective_to_cannot_be_before_effective_from
    return if effective_to.blank? || effective_from.blank?

    if effective_to < effective_from
      errors.add(:effective_to, "cannot be before effective from")
    end
  end
end
