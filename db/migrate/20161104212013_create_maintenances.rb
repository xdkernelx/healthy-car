class CreateMaintenances < ActiveRecord::Migration[5.0]
  def change
    create_table :maintenances do |t|
      t.integer :car_id
      # t.integer :ticket_id
      t.string :title, { limit: 64 }
      t.string :description
      t.integer :mileage
      t.integer :shop_id
      t.date :date_completed
      t.integer :rating

      t.timestamps
    end
  end
end
