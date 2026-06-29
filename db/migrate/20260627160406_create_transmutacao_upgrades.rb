class CreateTransmutacaoUpgrades < ActiveRecord::Migration[8.1]
  def change
    create_table :transmutacao_upgrades do |t|
      t.references :transmutacao, null: false, foreign_key: true
      t.references :upgrade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
