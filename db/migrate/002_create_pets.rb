class CreatePets < ActiveRecord::Migration[4.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :animal_class
      t.string :apendages
      t.string :temperment
      t.string :body_color
      t.string :eye_color
      t.string :birthdate
      t.integer :user_id
    end
  end
end
