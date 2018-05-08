class AddUniqueConstraintToUserAuth < ActiveRecord::Migration[5.1]
  def change
    add_index :user_auths, :identifier, unique: true
    add_index :user_auths, [:identifier, :identityType], unique: true
  end
end
