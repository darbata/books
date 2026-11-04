require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    @headers = sign_in_as(users(:one))
  end

  test "should get index" do
    get books_url, as: :json, headers: @headers
    assert_response :success
  end

  test "should create book" do
    assert_difference("Book.count") do
      post books_url, params: { book: { author: @book.author, isbn: 2234567890123, publication_date: @book.publication_date, title: @book.title } }, as: :json, headers: @headers
    end

    assert_response :created
  end

  test "own column defaults to false" do
    assert_difference("Book.count") do
      post books_url, params: { book: { author: @book.author, isbn: 2234567890123, publication_date: @book.publication_date, title: @book.title } }, as: :json, headers: @headers
    end

    new_book = Book.find_by(isbn: 2234567890123)
    assert_equal new_book.own, false

    assert_response :created
  end

  test "can create owned book" do
    assert_difference("Book.count") do
      post books_url, params: { book: { author: @book.author, isbn: 2234567890123, publication_date: @book.publication_date, title: @book.title, own: true } }, as: :json, headers: @headers
    end

    new_book = Book.find_by(isbn: 2234567890123)

    assert_equal new_book.own, true

    assert_response :created

  end


  test "should show book" do
    get book_url(@book), as: :json, headers: @headers
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { author: @book.author, isbn: @book.isbn, publication_date: @book.publication_date, title: @book.title } }, as: :json, headers: @headers
    assert_response :success
  end

  test "user can update book own status" do
    patch book_url(@book), params: { book: { author: @book.author, isbn: @book.isbn, publication_date: @book.publication_date, title: @book.title, own: true } }, as: :json, headers: @headers
    assert_equal @book.reload.own, true

    patch book_url(@book), params: { book: { author: @book.author, isbn: @book.isbn, publication_date: @book.publication_date, title: @book.title, own: false } }, as: :json, headers: @headers
    assert_equal @book.reload.own, false

    assert_response :success
  end

  test "should destroy book" do
    assert_difference("Book.count", -1) do
      delete book_url(@book), as: :json, headers: @headers
    end

    assert_response :no_content
  end

  test "users can update reading status to valid enumerated values" do
    %w[want reading read abandoned].each do |status|
      patch book_url(@book), params: { book: { reading_status: status } }, as: :json, headers: @headers
      assert_response :success
      assert_equal status, @book.reload.reading_status
    end
  end

  test "invalid reading status is rejected" do
    patch book_url(@book), params: { book: { reading_status: "invalid" } }, as: :json, headers: @headers
    assert_response :unprocessable_entity
    assert_includes response.parsed_body["reading_status"].join, "is not included"
  end
end
