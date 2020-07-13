class AddUrlToEncode < ActiveRecord::Migration[6.0]
  def change
    add_column :encodes, :url, :string
  end
end
