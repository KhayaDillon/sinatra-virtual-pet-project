class CreateAnimalClasses < ActiveRecord::Migration
  def change
    create_table :animal_classes do |t|
      t.string :name
    end
  end
end
