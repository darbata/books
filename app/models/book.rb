class Book < ApplicationRecord
  belongs_to :user

  validates :title, :author, :isbn, :publication_date, presence: true
  validates :isbn, uniqueness: true
  validate :publication_date_in_range
  validate :isbn_is_thirteen_digits_long

  private

  def publication_date_in_range
    return if publication_date.blank?

    unless publication_date > Date.new(1450, 1, 1) && publication_date < Date.current + 2.years
      errors.add(:publication_date, "must be between 1450 and 2 years from now")
    end
  end

  def isbn_is_thirteen_digits_long
    return if isbn.blank?

    unless isbn.digits.size == 13
      errors.add(:isbn, "must be 13 digits long")
    end
  end
end
