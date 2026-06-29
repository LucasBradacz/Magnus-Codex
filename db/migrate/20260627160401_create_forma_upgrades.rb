class CreateFormaUpgrades < ActiveRecord::Migration[8.1]
  def change
    create_table :forma_upgrades do |t|
      t.references :forma, null: false, foreign_key: true
      t.references :upgrade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
