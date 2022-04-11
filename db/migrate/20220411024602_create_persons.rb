class CreatePersons < ActiveRecord::Migration[6.1]
  def change
    create_table :persons do |t|
      t.string :rfc, null: false, index: true, unique: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
