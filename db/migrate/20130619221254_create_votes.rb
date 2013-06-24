class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :student
      t.references :award
      t.references :project
      t.timestamps
    end

    add_index :votes, :student_id
    add_index :votes, :award_id
    add_index :votes, :project_id
    add_index :votes, [:student_id, :award_id], :unique => true
  end
end
