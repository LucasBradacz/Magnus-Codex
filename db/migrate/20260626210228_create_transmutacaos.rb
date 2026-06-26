class CreateTransmutacaos < ActiveRecord::Migration[8.1]
  def change
    create_table :transmutacaos do |t|
      t.string :nome
      t.text :descricao
      t.string :dado_poder
      t.decimal :custo_multiplicador

      t.timestamps
    end
  end
end
