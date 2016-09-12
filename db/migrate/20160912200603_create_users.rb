class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email_address, :unique => true
      t.datetime :birthdate

      t.timestamps null: false
    end
  end
end
