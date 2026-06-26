class CreateFormas < ActiveRecord::Migration[8.1]
  def change
    create_table :formas do |t|
      t.string :nome
      t.text :descricao
      t.string :alcance
      t.string :tamanho
      t.string :duracao
      t.integer :custo_base
      t.integer :poder_base

      t.timestamps
    end
  end
end
