class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :beacon_ssn

      t.timestamps null: false
    end
  end
end
