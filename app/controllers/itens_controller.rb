class ItensController < ApplicationController
  before_action :set_personagem
  before_action :set_item, only: [:edit, :update, :destroy]

  def new
    @item = @personagem.itens.new
  end

  def create
    @item = @personagem.itens.new(item_params)
    if @item.save
      redirect_to personagem_path(@personagem), notice: "Item adicionado!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to personagem_path(@personagem), notice: "Item atualizado!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to personagem_path(@personagem), notice: "Item removido."
  end

  private

  def set_personagem
    @personagem = Personagem.find(params[:personagem_id])
  end

  def set_item
    @item = @personagem.itens.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:nome, :quantidade, :descricao, :acoes, :municao, :alcance, :dano)
  end
end