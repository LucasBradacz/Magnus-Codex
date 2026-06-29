class Personagem < ApplicationRecord
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
    nivel + dominio
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
end