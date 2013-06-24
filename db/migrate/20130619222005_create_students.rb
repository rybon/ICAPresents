class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :facebook_id
      t.string :name
      t.timestamps
    end
    
    add_index :students, :facebook_id, :unique => true
  end
end
