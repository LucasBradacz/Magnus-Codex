class PersonagemModificador < ApplicationRecord
  belongs_to :personagem
  belongs_to :modificador
end
