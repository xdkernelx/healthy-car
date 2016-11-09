class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.integer :car_id
      t.integer :issue_id
      t.string :report_type, { limit: 11 }
      t.string :token

      t.timestamps
    end
  end
end
