class PersonagemsController < ApplicationController
  before_action :set_personagem, only: %i[ show edit update destroy ]

  CAMPOS_EDITAVEIS = (
    %w[vida_atual mana_atual estabilidade_atual dinheiro] +
      Personagem::ATRIBUTOS +
      Personagem::CAMPOS_PENTAGRAMA
  ).freeze

  CAMPOS_LIMITADOS_POR_PONTOS = (Personagem::ATRIBUTOS + Personagem::CAMPOS_PENTAGRAMA).freeze

  DISCIPLINAS_ADJACENTES = {
    "superior" => ["esquerda_superior", "direita_superior"],
    "esquerda_superior" => ["superior", "esquerda_inferior"],
    "esquerda_inferior" => ["esquerda_superior", "direita_inferior"],
    "direita_inferior" => ["esquerda_inferior", "direita_superior"],
    "direita_superior" => ["direita_inferior", "superior"]
  }.freeze

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

  def subir_nivel
    @personagem = Personagem.find(params[:id])
    return if request.get? # so renderiza a tela de escolha

    aplicar_subida_de_nivel(@personagem, params[:disciplina])

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to personagem_path(@personagem), notice: "#{@personagem.nome} subiu para o nivel #{@personagem.nivel}!" }
    end
  end

  def edit_campo
    @personagem = Personagem.find(params[:id])
    @campo = params[:campo]
    raise ActionController::RoutingError, "campo inválido" unless CAMPOS_EDITAVEIS.include?(@campo)
    @label = label_para(@campo)
  end

  def update_campo
    @personagem = Personagem.find(params[:id])
    @campo = params[:campo]
    raise ActionController::RoutingError, "campo inválido" unless CAMPOS_EDITAVEIS.include?(@campo)

    novo_valor = params[:valor].to_i

    if CAMPOS_LIMITADOS_POR_PONTOS.include?(@campo)
      valor_atual = @personagem.public_send(@campo)
      delta = novo_valor - valor_atual

      if delta.positive? && delta > @personagem.pontos_atributo_disponiveis
        delta = @personagem.pontos_atributo_disponiveis # aumenta so o quanto sobrar
        novo_valor = valor_atual + delta
      end

      @personagem.pontos_atributo_disponiveis -= delta
    end

    @personagem.update!(@campo => novo_valor, pontos_atributo_disponiveis: @personagem.pontos_atributo_disponiveis)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @personagem }
    end
  end
  def incrementar_atributo
    @personagem = Personagem.find(params[:id])
    atributo = params[:atributo]
    raise ActionController::RoutingError, "atributo inválido" unless ATRIBUTOS_EDITAVEIS.include?(atributo)

    if @personagem.pontos_atributo_disponiveis > 0
      @personagem.increment!(atributo)
      @personagem.decrement!(:pontos_atributo_disponiveis)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @personagem }
    end
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

  helper_method :label_para
  def label_para(campo)
    {
      "vida_atual" => "Vida Atual",
      "mana_atual" => "Mana Atual",
      "estabilidade_atual" => "Estabilidade Atual",
      "dinheiro" => "Dinheiro",
      "agilidade" => "Agilidade",
      "dominio" => "Dominio",
      "percepcao" => "Percepcao",
      "potencia" => "Potencia",
      "resistencia" => "Resistencia",
      "nivel_superior" => "Superior",
      "nivel_esquerda_superior" => "Esq. Superior",
      "nivel_direita_superior" => "Dir. Superior",
      "nivel_esquerda_inferior" => "Esq. Inferior",
      "nivel_direita_inferior" => "Dir. Inferior"
    }[campo]
  end

  # Only allow a list of trusted parameters through.
  def personagem_params
    params.require(:personagem).permit(:nome, :player, :nivel, :agilidade, :dominio, :percepcao, :potencia, :resistencia, :vida_atual, :mana_atual, :estabilidade_atual, :dinheiro, :nivel_superior, :nivel_esquerda_superior, :nivel_direita_superior, :nivel_esquerda_inferior, :nivel_direita_inferior)
  end
end