class AddPokemonToPokespawns < ActiveRecord::Migration
  def change
    add_reference :pokespawns, :pokemon, index: true, foreign_key: true
  end
end
