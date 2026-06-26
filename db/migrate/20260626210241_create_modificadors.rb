class CreateModificadors < ActiveRecord::Migration[8.1]
  def change
    create_table :modificadors do |t|
      t.string :nome
      t.text :descricao
      t.string :operacao_custo
      t.decimal :valor_custo
      t.string :operacao_poder
      t.decimal :valor_poder
      t.text :efeito

      t.timestamps
    end
  end
end
