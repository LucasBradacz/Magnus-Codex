class AddImagemToCartas < ActiveRecord::Migration[8.1]
  def change
    add_column :formas, :imagem, :string
    add_column :transmutacaos, :imagem, :string
    add_column :modificadors, :imagem, :string
  end
end
