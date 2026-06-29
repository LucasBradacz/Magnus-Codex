class CreateModificadorUpgrades < ActiveRecord::Migration[8.1]
  def change
    create_table :modificador_upgrades do |t|
      t.references :modificador, null: false, foreign_key: true
      t.references :upgrade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
