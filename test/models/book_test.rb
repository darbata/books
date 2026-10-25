require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "book title must be present" do
    book = Book.new(title: "")
    book.valid?
    assert_includes book.errors.messages[:title], "can't be blank"
  end

  test "book author must be present" do
    book = Book.new(author: "")
    book.valid?
    assert_includes book.errors.messages[:author], "can't be blank"
  end

  test "book isbn must be present" do
    book = Book.new(isbn: nil)
    book.valid?
    assert_includes book.errors.messages[:isbn], "can't be blank"
  end

  test "book publication_date must be present" do
    book = Book.new(publication_date: nil)
    book.valid?
    assert_includes book.errors.messages[:publication_date], "can't be blank"
  end

  test "book publication_date must be within 1450 and 2 years from the current date" do
    book = Book.new(title: "book", author: "author", isbn: 9780000000001, publication_date: Date.current)
    assert book.valid?   # sanity check: the baseline is valid

    book.publication_date = Date.new(1449, 1, 1)
    assert book.invalid?
    assert_includes book.errors[:publication_date], "must be between 1450 and 2 years from now"

    book.publication_date = Date.current >> 36
    assert book.invalid?
    assert_includes book.errors[:publication_date], "must be between 1450 and 2 years from now"
  end
end
