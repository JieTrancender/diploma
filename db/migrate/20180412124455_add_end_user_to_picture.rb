class AddEndUserToPicture < ActiveRecord::Migration[5.1]
  def change
  	add_column :pictures, :endUser, :string, default: 'default'
  end
end
