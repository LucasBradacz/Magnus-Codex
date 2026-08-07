class AdicionarSuporteMultiplasTransmutacoes < ActiveRecord::Migration[8.1]
  def up
    create_table :encantamento_transmutacaos do |t|
      t.references :encantamento, null: false, foreign_key: true
      t.references :transmutacao, null: false, foreign_key: true
      t.integer :ordem
      t.timestamps
    end

    # migra os dados existentes (1 transmutacao por encantamento) pra tabela nova
    execute <<~SQL
      INSERT INTO encantamento_transmutacaos (encantamento_id, transmutacao_id, ordem, created_at, updated_at)
      SELECT id, transmutacao_id, 0, created_at, updated_at
      FROM encantamentos
      WHERE transmutacao_id IS NOT NULL
    SQL

    remove_foreign_key :encantamentos, :transmutacaos
    remove_column :encantamentos, :transmutacao_id
  end

  def down
    add_column :encantamentos, :transmutacao_id, :bigint
    add_foreign_key :encantamentos, :transmutacaos

    execute <<~SQL
      UPDATE encantamentos e
      SET transmutacao_id = (
        SELECT transmutacao_id FROM encantamento_transmutacaos
        WHERE encantamento_id = e.id ORDER BY ordem LIMIT 1
      )
    SQL

    change_column_null :encantamentos, :transmutacao_id, false
    add_index :encantamentos, :transmutacao_id

    drop_table :encantamento_transmutacaos
  end
end