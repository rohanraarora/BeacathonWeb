class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :token
      t.date :token_expiry_date

      t.timestamps null: false
    end
  end
end
