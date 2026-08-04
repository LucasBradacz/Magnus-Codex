class AddDetalhesToEncantamentos < ActiveRecord::Migration[8.1]
  def change
    add_column :encantamentos, :alcance, :string
    add_column :encantamentos, :tamanho, :string
    add_column :encantamentos, :duracao, :string
  end
end
