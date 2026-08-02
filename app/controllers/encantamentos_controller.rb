class EncantamentosController < ApplicationController
  before_action :set_personagem
  before_action :carregar_opcoes

  def new
    @encantamento = novo_encantamento
    @modificador_ids_selecionados = []
    @resultado = nil
  end

  def create
    @encantamento = novo_encantamento(encantamento_params)

    if @encantamento.save
      modificador_ids_atuais.each_with_index do |mod_id, index|
        @encantamento.encantamento_modificadors.create!(modificador_id: mod_id, ordem: index)
      end
      @encantamento.recalcular!
      redirect_to destino_apos_salvar, notice: "Encantamento salvo com sucesso!"
    else
      @modificador_ids_selecionados = modificador_ids_atuais
      @resultado = calcular_resultado
      render :new, status: :unprocessable_entity
    end
  end

  def preview
    @encantamento = novo_encantamento(encantamento_params)
    @modificador_ids_selecionados = modificador_ids_atuais
    @resultado = calcular_resultado
    respond_to { |format| format.turbo_stream }
  end

  private

  def set_personagem
    @personagem = Personagem.find(params[:personagem_id]) if params[:personagem_id].present?
  end

  def novo_encantamento(attrs = {})
    @personagem ? @personagem.encantamentos.new(attrs) : Encantamento.new(attrs)
  end

  def destino_apos_salvar
    @personagem ? personagem_path(@personagem) : root_path
  end

  def preview_path_atual
    @personagem ? preview_personagem_encantamentos_path(@personagem) : preview_encantamentos_path
  end
  helper_method :preview_path_atual

  def carregar_opcoes
    if @personagem
      @formas = @personagem.formas_disponiveis.order(:nome)
      @transmutacaos = @personagem.transmutacaos_disponiveis.order(:nome)
      @modificadors = @personagem.modificadors_disponiveis.order(:nome)
    else
      @formas = Forma.order(:nome)
      @transmutacaos = Transmutacao.order(:nome)
      @modificadors = Modificador.order(:nome)
    end
  end

  def encantamento_params
    params.require(:encantamento).permit(:nome, :forma_id, :transmutacao_id)
  end

  def modificador_ids_atuais
    existentes = Array(params[:modificador_ids]).reject(&:blank?)
    existentes += [params[:novo_modificador_id]] if params[:novo_modificador_id].present?

    if params[:remover_indice].present?
      existentes.delete_at(params[:remover_indice].to_i)
    end

    existentes
  end

  def calcular_resultado
    forma = Forma.find_by(id: encantamento_params[:forma_id])
    transmutacao = Transmutacao.find_by(id: encantamento_params[:transmutacao_id])
    return nil unless forma && transmutacao

    ids = modificador_ids_atuais
    por_id = Modificador.where(id: ids).index_by { |m| m.id.to_s }
    modificadores = ids.map { |id| por_id[id] }.compact

    CalculoEncantamento.new(forma: forma, transmutacao: transmutacao, modificadores: modificadores).calcular
  end
end