class CreatePersonagemFormas < ActiveRecord::Migration[8.1]
  def change
    create_table :personagem_formas do |t|
      t.references :personagem, null: false, foreign_key: true
      t.references :forma, null: false, foreign_key: true

      t.timestamps
    end
    add_index :personagem_formas, [:personagem_id, :forma_id], unique: true
  end
end
