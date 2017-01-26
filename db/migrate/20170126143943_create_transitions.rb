class CreateTransitions < ActiveRecord::Migration[5.0]
  def change
    create_table :transitions do |t|
      t.string :from
      t.string :to
      t.boolean :active

      t.timestamps
    end

    add_index :transitions, :active
    add_index :transitions, [:active, :from, :to], unique: true
  end
end
