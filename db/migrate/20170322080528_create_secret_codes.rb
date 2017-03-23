class CreateSecretCodes < ActiveRecord::Migration
  def change
    create_table :secret_codes do |t|
      t.string :code
      t.integer :user_id
      t.string :created_by
      t.string :updated_by	 
      t.timestamps

    end
    add_index :secret_codes,:code
  end
end
