class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.references :user, index: true, foreign_key: true
      t.references :wiki, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :users, :id, unique: true
    add_index :wikis, :id, unique: true
    add_index :collaborators, :id, unique: true
  end
end
