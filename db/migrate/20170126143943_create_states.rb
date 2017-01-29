class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :name
      t.integer :from_state_id, references: :states, unique: true

      t.timestamps
    end

    add_index :states, :name, unique: true
  end
end
