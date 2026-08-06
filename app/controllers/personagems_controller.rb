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

    if @personagem.save
      redirect_to edit_personagem_cartas_conhecidas_path(@personagem),
                  notice: "Personagem criado! Agora escolha as cartas conhecidas."
    else
      render :new, status: :unprocessable_entity
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
      format.html { redirect_to personagens_path, notice: "Personagem apagado com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  DISCIPLINAS_ADJACENTES = {
    "superior" => ["esquerda_superior", "direita_superior"],
    "esquerda_superior" => ["superior", "esquerda_inferior"],
    "esquerda_inferior" => ["esquerda_superior", "direita_inferior"],
    "direita_inferior" => ["esquerda_inferior", "direita_superior"],
    "direita_superior" => ["direita_inferior", "superior"]
  }.freeze

  def subir_nivel
    @personagem = Personagem.find(params[:id])
    return if request.get? # so renderiza a tela de escolha

    aplicar_subida_de_nivel(@personagem, params[:disciplina])
    redirect_to personagem_path(@personagem), notice: "#{@personagem.nome} subiu para o nivel #{@personagem.nivel}!"
  end

  private

  def aplicar_subida_de_nivel(personagem, disciplina_escolhida)
    campo = "nivel_#{disciplina_escolhida}"
    novo_valor = personagem[campo] + 1
    personagem[campo] = novo_valor

    if novo_valor.even?
      DISCIPLINAS_ADJACENTES[disciplina_escolhida].each do |adjacente|
        campo_adjacente = "nivel_#{adjacente}"
        valor_adjacente = personagem[campo_adjacente]
        next if valor_adjacente.to_i >= novo_valor # excecao: adjacente ja maior nao ganha

        personagem[campo_adjacente] = valor_adjacente + 1
      end
    end

    personagem.nivel += 1
    personagem.pontos_atributo_disponiveis += 1
    personagem.save!
  end
    def set_personagem
      @personagem = Personagem.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
  def personagem_params
    params.require(:personagem).permit(:nome, :player, :nivel, :agilidade, :dominio, :percepcao, :potencia, :resistencia, :vida_atual, :mana_atual, :estabilidade_atual, :dinheiro, :nivel_superior, :nivel_esquerda_superior, :nivel_direita_superior, :nivel_esquerda_inferior, :nivel_direita_inferior)
  end
end
