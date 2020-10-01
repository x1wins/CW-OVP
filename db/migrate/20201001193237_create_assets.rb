class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.string :format
      t.string :url
      t.references :encode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
