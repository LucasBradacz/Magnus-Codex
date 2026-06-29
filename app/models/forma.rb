class Forma < ApplicationRecord
  def basica?
    basica
  end

  def disciplina_nome
    case disciplina
    when "superior" then "Superior (Vida/Cura)"
    when "esquerda_superior" then "Esquerda Superior (Mente)"
    when "direita_superior" then "Direita Superior (Melhoria)"
    when "esquerda_inferior" then "Esquerda Inferior (Contencao)"
    when "direita_inferior" then "Direita Inferior (Destruicao)"
    else "Basica"
    end
  end
end