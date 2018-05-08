class CreateUserAuths < ActiveRecord::Migration[5.1]
  def change
    create_table :user_auths do |t|
      t.string :identityType
      t.string :identifier
      t.string :credential
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
