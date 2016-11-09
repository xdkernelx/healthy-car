class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :name, { limit: 64 }
      t.integer :mechanic_id
      t.string :address, { limit: 128 }
      t.string :city, { limit: 64 }
      t.string :state
      t.string :zip_code, { limit: 5 }
      t.string :phone, { default: "" }

      t.timestamps
    end
  end
end
