class AddIconToPokespawn < ActiveRecord::Migration
  def change
    add_column :pokespawns, :icon, :string
  end
end
