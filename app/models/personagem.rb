class Personagem < ApplicationRecord
  has_many :personagem_formas, dependent: :destroy
  has_many :formas, through: :personagem_formas

  has_many :personagem_transmutacaos, dependent: :destroy
  has_many :transmutacaos, through: :personagem_transmutacaos

  has_many :personagem_modificadors, dependent: :destroy
  has_many :modificadors, through: :personagem_modificadors

  has_many :encantamentos, dependent: :destroy
  has_many :itens, dependent: :destroy
  def vida_max
    nivel * (20 + 2 * resistencia)
  end

  def ca
    7 + nivel + (agilidade / 2)
  end

  def mana_max
    nivel * 20
  end

  def estabilidade_max
    (nivel + resistencia) / 2
  end

  def acoes
    (4 + agilidade + nivel) / 2
  end

  def acerto
    nivel + (dominio / 2)
  end

  def movimento
    8
  end

  def dano_extra
    potencia + nivel
  end

  def cm
    nivel * 10
  end

  def truque
    5 + (5 * (nivel / 2))
  end

  def formas_disponiveis
    formas
  end

  def transmutacaos_disponiveis
    transmutacaos
  end

  def modificadors_disponiveis
    modificadors
  end
end