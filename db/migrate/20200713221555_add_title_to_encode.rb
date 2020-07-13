class AddTitleToEncode < ActiveRecord::Migration[6.0]
  def change
    add_column :encodes, :title, :string
  end
end
