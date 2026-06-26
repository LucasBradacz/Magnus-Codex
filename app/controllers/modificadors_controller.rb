class ModificadorsController < ApplicationController
  before_action :set_modificador, only: %i[ show edit update destroy ]

  # GET /modificadors or /modificadors.json
  def index
    @modificadors = Modificador.all
  end

  # GET /modificadors/1 or /modificadors/1.json
  def show
  end

  # GET /modificadors/new
  def new
    @modificador = Modificador.new
  end

  # GET /modificadors/1/edit
  def edit
  end

  # POST /modificadors or /modificadors.json
  def create
    @modificador = Modificador.new(modificador_params)

    respond_to do |format|
      if @modificador.save
        format.html { redirect_to @modificador, notice: "Modificador was successfully created." }
        format.json { render :show, status: :created, location: @modificador }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @modificador.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /modificadors/1 or /modificadors/1.json
  def update
    respond_to do |format|
      if @modificador.update(modificador_params)
        format.html { redirect_to @modificador, notice: "Modificador was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @modificador }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @modificador.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /modificadors/1 or /modificadors/1.json
  def destroy
    @modificador.destroy!

    respond_to do |format|
      format.html { redirect_to modificadors_path, notice: "Modificador was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modificador
      @modificador = Modificador.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def modificador_params
      params.expect(modificador: [ :nome, :descricao, :operacao_custo, :valor_custo, :operacao_poder, :valor_poder, :efeito ])
    end
end
