class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :teacher
      t.string :content
      t.timestamps
    end

    add_index :messages, :teacher_id
  end
end
