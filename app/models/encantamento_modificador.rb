class EncantamentoModificador < ApplicationRecord
  belongs_to :encantamento
  belongs_to :modificador
end