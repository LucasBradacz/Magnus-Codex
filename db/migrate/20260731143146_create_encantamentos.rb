class CreateEncantamentos < ActiveRecord::Migration[8.1]
  def change
    create_table :encantamentos do |t|
      t.string :nome
      t.references :personagem, null: false, foreign_key: true
      t.references :forma, null: false, foreign_key: true
      t.references :transmutacao, null: false, foreign_key: true
      t.integer :custo_final
      t.string :poder_final

      t.timestamps
    end
  end
end
