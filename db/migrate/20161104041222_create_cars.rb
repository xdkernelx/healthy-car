class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.integer :user_id
      t.string :vin, { limit: 17 }
      t.integer :mileage
      t.integer	:year
      t.string	:make
      t.string	:model
      t.string	:color
      t.string	:transmission
      t.string	:engine

      t.timestamps
    end
  end
end
