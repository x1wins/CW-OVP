class ChangeRuntimeToEncode < ActiveRecord::Migration[6.0]
  def change
    change_column :encodes, :runtime, :string
  end
end
