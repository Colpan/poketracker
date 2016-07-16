class AddPokeiconToPokespawns < ActiveRecord::Migration
  def change
    add_column :pokespawns, :pokeicon, :string
  end
end
