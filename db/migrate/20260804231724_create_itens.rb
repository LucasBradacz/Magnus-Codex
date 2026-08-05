class CreateItens < ActiveRecord::Migration[8.1]
  def change
    create_table :itens do |t|
      t.references :personagem, null: false, foreign_key: true
      t.string :nome, null: false
      t.integer :quantidade, default: 1, null: false
      t.text :descricao
      t.integer :acoes
      t.string :municao
      t.string :alcance
      t.string :dano

      t.timestamps
    end
  end
end