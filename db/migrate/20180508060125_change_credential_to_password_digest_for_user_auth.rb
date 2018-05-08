class ChangeCredentialToPasswordDigestForUserAuth < ActiveRecord::Migration[5.1]
  def change
  	rename_column :user_auths, :credential, :password_digest
  end
end
