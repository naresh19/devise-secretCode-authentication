class CreateSecretCodes < ActiveRecord::Migration
  def change
    create_table :secret_codes do |t|
      t.string :code
      t.integer :user_id
      t.string :created_by
      t.string :updated_by	 
      t.timestamps
      add_index :user_id
    end
  end
end
