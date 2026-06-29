class AddComplexaToCartas < ActiveRecord::Migration[8.1]
  def change
    add_column :formas, :complexa, :boolean, default: false, null: false
    add_column :transmutacaos, :complexa, :boolean, default: false, null: false
    add_column :modificadors, :complexa, :boolean, default: false, null: false

    create_table :forma_upgrades do |t|
      t.references :forma, null: false, foreign_key: true
      t.references :upgrade, null: false, foreign_key: { to_table: :formas }
      t.timestamps
    end

    create_table :transmutacao_upgrades do |t|
      t.references :transmutacao, null: false, foreign_key: true
      t.references :upgrade, null: false, foreign_key: { to_table: :transmutacaos }
      t.timestamps
    end

    create_table :modificador_upgrades do |t|
      t.references :modificador, null: false, foreign_key: true
      t.references :upgrade, null: false, foreign_key: { to_table: :modificadors }
      t.timestamps
    end
  end
end