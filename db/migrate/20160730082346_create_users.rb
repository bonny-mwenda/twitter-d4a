class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.date :date_of_birth
      t.string :gender
      t.string :email
      t.string :profile_picture

      t.timestamps null: false
    end
  end
end
