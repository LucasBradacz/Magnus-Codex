class Encantamento < ApplicationRecord
  belongs_to :personagem, optional: true
  belongs_to :forma
  has_many :encantamento_transmutacaos, -> { order(:ordem) }, dependent: :destroy
  has_many :transmutacaos, through: :encantamento_transmutacaos
  has_many :encantamento_modificadors, -> { order(:ordem) }, dependent: :destroy
  has_many :modificadors, through: :encantamento_modificadors

  validates :nome, presence: true

  def recalcular!
    resultado = CalculoEncantamento.new(
      forma: forma, transmutacaos: transmutacaos, modificadores: modificadors
    ).calcular

    update!(
      custo_final: resultado.custo_final,
      poder_final: resultado.poder_formatado,
      alcance: resultado.alcance,
      tamanho: resultado.tamanho,
      duracao: resultado.duracao
    )
  end

  def acoes_necessarias
    1 + transmutacaos.count + encantamento_modificadors.count
  end
end