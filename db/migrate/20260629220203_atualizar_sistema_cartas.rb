class AtualizarSistemaCartas < ActiveRecord::Migration[8.1]
  def change
    # Remover tabelas de upgrades
    drop_table :forma_upgrades
    drop_table :transmutacao_upgrades
    drop_table :modificador_upgrades

    # Remover coluna complexa e adicionar novos campos nas cartas
    remove_column :formas, :complexa
    add_column :formas, :basica, :boolean, default: false, null: false
    add_column :formas, :disciplina, :string
    add_column :formas, :nivel_minimo, :integer

    remove_column :transmutacaos, :complexa
    add_column :transmutacaos, :basica, :boolean, default: false, null: false
    add_column :transmutacaos, :disciplina, :string
    add_column :transmutacaos, :nivel_minimo, :integer

    remove_column :modificadors, :complexa
    add_column :modificadors, :basica, :boolean, default: false, null: false
    add_column :modificadors, :disciplina, :string
    add_column :modificadors, :nivel_minimo, :integer

    # Adicionar disciplinas do pentagrama no personagem
    add_column :personagens, :nivel_superior, :integer, default: 0
    add_column :personagens, :nivel_esquerda_superior, :integer, default: 0
    add_column :personagens, :nivel_direita_superior, :integer, default: 0
    add_column :personagens, :nivel_esquerda_inferior, :integer, default: 0
    add_column :personagens, :nivel_direita_inferior, :integer, default: 0
  end
end