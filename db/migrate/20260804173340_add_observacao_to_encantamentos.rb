class AddObservacaoToEncantamentos < ActiveRecord::Migration[8.1]
  def change
    add_column :encantamentos, :observacao, :text
  end
end
