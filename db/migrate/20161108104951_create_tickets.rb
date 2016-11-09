class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :title, { limit: 64 }
      t.string :description
      t.boolean :public_access, { default: false }
      t.integer :user_id
      t.integer :car_id

      t.timestamps
    end
  end
end
