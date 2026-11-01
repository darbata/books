class AddOwnToBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :books, :own, :boolean, default: false
  end
end
