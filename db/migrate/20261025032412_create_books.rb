class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :isbn
      t.date :publication_date

      t.timestamps
    end
  end
end
