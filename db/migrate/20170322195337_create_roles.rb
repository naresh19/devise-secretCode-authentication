class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name,:null=>false
      t.string :created_by
      t.string :updated_by
      t.timestamps
    end
  end
end
