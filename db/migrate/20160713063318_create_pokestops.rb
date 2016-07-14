class CreatePokestops < ActiveRecord::Migration
  def change
    create_table :pokestops do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
