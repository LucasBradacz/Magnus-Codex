# app/models/encantamento.rb
class Encantamento < ApplicationRecord
  belongs_to :personagem, optional: true
  belongs_to :forma
  belongs_to :transmutacao
  has_many :encantamento_modificadors, -> { order(:ordem) }, dependent: :destroy
  has_many :modificadors, through: :encantamento_modificadors

  validates :nome, presence: true

  def recalcular!
    resultado = CalculoEncantamento.new(
      forma: forma, transmutacao: transmutacao, modificadores: modificadors
    ).calcular
    update!(custo_final: resultado.custo_final, poder_final: resultado.poder_formatado)
  end
end