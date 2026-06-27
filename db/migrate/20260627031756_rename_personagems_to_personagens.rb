class RenamePersonagemsToPersonagens < ActiveRecord::Migration[8.1]
  def change
    rename_table :personagems, :personagens
  end
end