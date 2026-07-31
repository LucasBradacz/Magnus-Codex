class CreateEncantamentoModificadors < ActiveRecord::Migration[8.1]
  def change
    create_table :encantamento_modificadors do |t|
      t.references :encantamento, null: false, foreign_key: true
      t.references :modificador, null: false, foreign_key: true
      t.integer :ordem

      t.timestamps
    end
  end
end
