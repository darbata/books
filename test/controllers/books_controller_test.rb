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

  test "should show book" do
    get book_url(@book), as: :json, headers: @headers
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { author: @book.author, isbn: @book.isbn, publication_date: @book.publication_date, title: @book.title } }, as: :json, headers: @headers
    assert_response :success
  end

  test "should destroy book" do
    assert_difference("Book.count", -1) do
      delete book_url(@book), as: :json, headers: @headers
    end

    assert_response :no_content
  end
end
