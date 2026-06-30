class FormasController < ApplicationController
  before_action :set_forma, only: %i[ show edit update destroy ]

  # GET /formas or /formas.json
  def index
    @formas_basicas = Forma.where(basica: true)
    @formas_disciplina = Forma.where(basica: false)
  end

  # GET /formas/1 or /formas/1.json
  def show
  end

  # GET /formas/new
  def new
    @forma = Forma.new
  end

  # GET /formas/1/edit
  def edit
  end

  # POST /formas or /formas.json
  def create
    @forma = Forma.new(forma_params)

    respond_to do |format|
      if @forma.save
        format.html { redirect_to @forma, notice: "Forma criada com sucesso." }
        format.json { render :show, status: :created, location: @forma }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @forma.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /formas/1 or /formas/1.json
  def update
    respond_to do |format|
      if @forma.update(forma_params)
        format.html { redirect_to @forma, notice: "Forma atualizada com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @forma }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @forma.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /formas/1 or /formas/1.json
  def destroy
    @forma.destroy!

    respond_to do |format|
      format.html { redirect_to formas_path, notice: "Forma apagada com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_forma
    @forma = Forma.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def forma_params
    params.require(:forma).permit(:nome, :descricao, :alcance, :tamanho, :duracao, :custo_base, :poder_base, :basica, :disciplina, :nivel_minimo)
  end
end
