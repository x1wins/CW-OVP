class CreateWebhooks < ActiveRecord::Migration[6.0]
  def change
    create_table :webhooks do |t|
      t.string :url
      t.string :api_key
      t.integer :user_id
      t.string :method
      t.boolean :is_active

      t.timestamps
    end
  end
end
