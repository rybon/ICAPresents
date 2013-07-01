class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :author, :polymorphic => true
      t.string :title
      t.string :students
      t.string :semester
      t.string :location
      t.string :time
      t.text :description
      t.string :picture
      t.boolean :approved, default: false
      t.timestamps
    end

    add_index :projects, [:author_id, :author_type]
    add_index :projects, [:title, :students, :semester, :description], name: 'search'
  end
end
