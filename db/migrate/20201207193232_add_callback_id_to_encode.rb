class AddCallbackIdToEncode < ActiveRecord::Migration[6.0]
  def change
    add_column :encodes, :callback_id, :integer
  end
end
