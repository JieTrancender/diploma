class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :key
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :pictures, [:key, :url, :created_at]
  end
end
