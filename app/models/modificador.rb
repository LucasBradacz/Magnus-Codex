class Modificador < ApplicationRecord
  def disciplina_nome
    case disciplina
    when "superior" then "Superior (Vida/Cura)"
    when "esquerda_superior" then "Esquerda Superior (Mente)"
    when "direita_superior" then "Direita Superior (Melhoria)"
    when "esquerda_inferior" then "Esquerda Inferior (Contenção)"
    when "direita_inferior" then "Direita Inferior (Destruição)"
    else "Básica"
    end
  end
end
