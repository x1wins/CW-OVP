class CreateEncodes < ActiveRecord::Migration[6.0]
  def change
    create_table :encodes do |t|
      t.text :log
      t.timestamp :started_at
      t.timestamp :ended_at
      t.float :runtime
      t.boolean :completed
      t.references :user, null: false, foreign_key: true
      t.boolean :published

      t.timestamps
    end
  end
end
