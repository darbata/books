class AddReadingStatusToBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :books, :reading_status, :string, default: "want"
  end
end
