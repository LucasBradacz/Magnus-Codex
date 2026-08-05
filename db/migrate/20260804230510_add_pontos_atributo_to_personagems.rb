class AddPontosAtributoToPersonagems < ActiveRecord::Migration[8.1]
  def change
    add_column :personagens, :pontos_atributo_disponiveis, :integer, default: 0, null: false
  end
end