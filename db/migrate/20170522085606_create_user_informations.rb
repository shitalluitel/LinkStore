class CreateUserInformations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_informations do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :country
      t.string :state
      t.string :photo
      t.string :phone_no
      t.string :city
      t.string :religion
      t.date :dob
      t.string :gender
      t.integer :user_id

      t.timestamps
    end
  end
end
