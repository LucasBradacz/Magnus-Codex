class CreatePersonagemModificadors < ActiveRecord::Migration[8.1]
  def change
    create_table :personagem_modificadors do |t|
      t.references :personagem, null: false, foreign_key: true
      t.references :modificador, null: false, foreign_key: true

      t.timestamps
    end
    add_index :personagem_modificadors, [:personagem_id, :modificador_id], unique: true
  end
end
