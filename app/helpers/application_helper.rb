# app/helpers/application_helper.rb
module ApplicationHelper
  def imagem_carta(carta)
    return if carta.imagem.blank?

    caminho = carta.imagem.gsub("app/assets/images/", "")
    image_tag(caminho, style: "width: 100%; border-radius: 4px;")
  end
end