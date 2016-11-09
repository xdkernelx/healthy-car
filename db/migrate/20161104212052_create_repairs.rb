class CreateRepairs < ActiveRecord::Migration[5.0]
  def change
    create_table :repairs do |t|
      t.integer :repairable_id
      t.string :repairable_type
      t.string :title, { limit: 64 }
      t.string :description
      t.integer :mileage
      t.integer :shop_id
      t.date :date_completed
      t.integer :rating

      t.timestamps
    end
    add_index :repairs, [:repairable_type, :repairable_id]
  end
end
