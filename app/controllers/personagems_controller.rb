class PersonagemsController < ApplicationController
  before_action :set_personagem, only: %i[ show edit update destroy ]

  # GET /personagems or /personagems.json
  def index
    @personagems = Personagem.all
  end

  # GET /personagems/1 or /personagems/1.json
  def show
  end

  # GET /personagems/new
  def new
    @personagem = Personagem.new
  end

  # GET /personagems/1/edit
  def edit
  end

  # POST /personagems or /personagems.json
  def create
    @personagem = Personagem.new(personagem_params)

    respond_to do |format|
      if @personagem.save
        format.html { redirect_to @personagem, notice: "Personagem criado com sucesso." }
        format.json { render :show, status: :created, location: @personagem }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @personagem.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /personagems/1 or /personagems/1.json
  def update
    respond_to do |format|
      if @personagem.update(personagem_params)
        format.html { redirect_to @personagem, notice: "Personagem atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @personagem }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @personagem.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /personagems/1 or /personagems/1.json
  def destroy
    @personagem.destroy!

    respond_to do |format|
      format.html { redirect_to personagems_path, notice: "Personagem apagado com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personagem
      @personagem = Personagem.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
  def personagem_params
    params.require(:personagem).permit(:nome, :player, :nivel, :agilidade, :dominio, :percepcao, :potencia, :resistencia, :vida_atual, :mana_atual, :estabilidade_atual, :dinheiro, :nivel_superior, :nivel_esquerda_superior, :nivel_direita_superior, :nivel_esquerda_inferior, :nivel_direita_inferior)
  end
end
