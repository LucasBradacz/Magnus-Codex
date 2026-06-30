class TransmutacaosController < ApplicationController
  before_action :set_transmutacao, only: %i[ show edit update destroy ]

  # GET /transmutacaos or /transmutacaos.json
  def index
    @transmutacaos_basicas = Transmutacao.where(basica: true)
    @transmutacaos_disciplina = Transmutacao.where(basica: false)
  end

  # GET /transmutacaos/1 or /transmutacaos/1.json
  def show
  end

  # GET /transmutacaos/new
  def new
    @transmutacao = Transmutacao.new
  end

  # GET /transmutacaos/1/edit
  def edit
  end

  # POST /transmutacaos or /transmutacaos.json
  def create
    @transmutacao = Transmutacao.new(transmutacao_params)

    respond_to do |format|
      if @transmutacao.save
        format.html { redirect_to @transmutacao, notice: "Transmutação criada com sucesso." }
        format.json { render :show, status: :created, location: @transmutacao }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @transmutacao.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /transmutacaos/1 or /transmutacaos/1.json
  def update
    respond_to do |format|
      if @transmutacao.update(transmutacao_params)
        format.html { redirect_to @transmutacao, notice: "Transmutação atualizada com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @transmutacao }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @transmutacao.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /transmutacaos/1 or /transmutacaos/1.json
  def destroy
    @transmutacao.destroy!

    respond_to do |format|
      format.html { redirect_to transmutacaos_path, notice: "Transmutação apagada com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transmutacao
    @transmutacao = Transmutacao.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def transmutacao_params
    params.require(:transmutacao).permit(:nome, :descricao, :dado_poder, :custo_multiplicador, :basica, :disciplina, :nivel_minimo)
  end
end
