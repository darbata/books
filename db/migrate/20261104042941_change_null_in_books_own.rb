class ChangeNullInBooksOwn < ActiveRecord::Migration[8.1]
  def change
    change_column_default :books, :own, from: nil, to: false
    change_column_null :books, :own, false, false
  end
end
