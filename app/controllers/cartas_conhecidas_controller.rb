class CartasConhecidasController < ApplicationController
  before_action :set_personagem

  def edit
    @formas = Forma.order(:nome)
    @transmutacaos = Transmutacao.order(:nome)
    @modificadors = Modificador.order(:nome)
  end

  def update
    @personagem.forma_ids = Array(params[:forma_ids]).reject(&:blank?)
    @personagem.transmutacao_ids = Array(params[:transmutacao_ids]).reject(&:blank?)
    @personagem.modificador_ids = Array(params[:modificador_ids]).reject(&:blank?)

    redirect_to personagem_path(@personagem), notice: "Cartas conhecidas atualizadas!"
  end

  private

  def set_personagem
    @personagem = Personagem.find(params[:personagem_id])
  end
end