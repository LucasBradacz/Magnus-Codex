class MakePersonagemOptionalOnEncantamentos < ActiveRecord::Migration[8.1]
  def change
    change_column_null :encantamentos, :personagem_id, true
  end
end
