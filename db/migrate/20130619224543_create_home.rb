class CreateHome < ActiveRecord::Migration
  def change
    create_table :home do |t|
      t.datetime :ica_presents_begins
      t.text :program
      t.text :about
      t.timestamps
    end
  end
end
