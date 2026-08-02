class CreatePersonagemTransmutacaos < ActiveRecord::Migration[8.1]
  def change
    create_table :personagem_transmutacaos do |t|

      t.references :personagem, null: false, foreign_key: true
      t.references :transmutacao, null: false, foreign_key: true

      t.timestamps
    end
    add_index :personagem_transmutacaos, [:personagem_id, :transmutacao_id], unique: true
  end
end
