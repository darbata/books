class Book < ApplicationRecord
  validates :title, :author, :isbn, :publication_date, presence: true
  validates :isbn, uniqueness: true
end
