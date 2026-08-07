class EncantamentosController < ApplicationController
  before_action :set_personagem
  before_action :carregar_opcoes
  before_action :set_encantamento, only: [:edit, :update]

  def new
    @encantamento = novo_encantamento
    @modificador_ids_selecionados = []
    @transmutacao_ids_selecionados = []
    @resultado = nil
  end

  def create
    @encantamento = novo_encantamento(encantamento_params)
    salvar_encantamento(notice: "Encantamento salvo com sucesso!", template: :new)
  end

  def edit
    @modificador_ids_selecionados = @encantamento.modificadors.pluck(:id).map(&:to_s)
    @transmutacao_ids_selecionados = @encantamento.encantamento_transmutacaos.order(:ordem).pluck(:transmutacao_id).map(&:to_s)
    @resultado = resultado_para_encantamento(@encantamento)
  end

  def update
    @encantamento.assign_attributes(encantamento_params)
    salvar_encantamento(notice: "Encantamento atualizado com sucesso!", template: :edit)
  end

  def preview
    @encantamento = params[:id] ? Encantamento.find(params[:id]) : novo_encantamento
    @encantamento.assign_attributes(encantamento_params)
    @modificador_ids_selecionados = modificador_ids_atuais
    @transmutacao_ids_selecionados = transmutacao_ids_atuais
    @resultado = calcular_resultado
    respond_to { |format| format.turbo_stream }
  end

  private

  def set_personagem
    @personagem = Personagem.find(params[:personagem_id]) if params[:personagem_id].present?
  end

  def set_encantamento
    @encantamento = Encantamento.find(params[:id])
  end

  def novo_encantamento(attrs = {})
    @personagem ? @personagem.encantamentos.new(attrs) : Encantamento.new(attrs)
  end

  def salvar_encantamento(notice:, template:)
    if @encantamento.save
      @encantamento.encantamento_modificadors.destroy_all
      modificador_ids_atuais.each_with_index do |mod_id, index|
        @encantamento.encantamento_modificadors.create!(modificador_id: mod_id, ordem: index)
      end

      @encantamento.encantamento_transmutacaos.destroy_all
      transmutacao_ids_atuais.each_with_index do |trans_id, index|
        @encantamento.encantamento_transmutacaos.create!(transmutacao_id: trans_id, ordem: index)
      end

      @encantamento.recalcular!
      redirect_to destino_apos_salvar, notice: notice
    else
      @modificador_ids_selecionados = modificador_ids_atuais
      @transmutacao_ids_selecionados = transmutacao_ids_atuais
      @resultado = calcular_resultado
      render template, status: :unprocessable_entity
    end
  end

  def destino_apos_salvar
    @personagem ? personagem_path(@personagem) : root_path
  end

  def preview_path_atual
    if @encantamento&.persisted?
      @personagem ? preview_personagem_encantamento_path(@personagem, @encantamento) : preview_encantamento_path(@encantamento)
    else
      @personagem ? preview_personagem_encantamentos_path(@personagem) : preview_encantamentos_path
    end
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

  # transmutacao_id sai daqui — nao existe mais como coluna
  def encantamento_params
    params.require(:encantamento).permit(:nome, :forma_id, :observacao)
  end

  def modificador_ids_atuais
    existentes = Array(params[:modificador_ids]).reject(&:blank?)
    existentes += [params[:novo_modificador_id]] if params[:novo_modificador_id].present?
    existentes.delete_at(params[:remover_indice].to_i) if params[:remover_indice].present?
    existentes
  end

  def transmutacao_ids_atuais
    existentes = Array(params[:transmutacao_ids]).reject(&:blank?)
    existentes += [params[:novo_transmutacao_id]] if params[:novo_transmutacao_id].present?
    existentes.delete_at(params[:remover_transmutacao_indice].to_i) if params[:remover_transmutacao_indice].present?
    existentes.first(2)
  end

  def calcular_resultado
    forma = Forma.find_by(id: encantamento_params[:forma_id])

    trans_ids = transmutacao_ids_atuais
    return nil if forma.nil? || trans_ids.empty?

    por_trans_id = Transmutacao.where(id: trans_ids).index_by { |t| t.id.to_s }
    transmutacaos = trans_ids.map { |id| por_trans_id[id] }.compact

    mod_ids = modificador_ids_atuais
    por_mod_id = Modificador.where(id: mod_ids).index_by { |m| m.id.to_s }
    modificadores = mod_ids.map { |id| por_mod_id[id] }.compact

    CalculoEncantamento.new(forma: forma, transmutacaos: transmutacaos, modificadores: modificadores).calcular
  end

  def resultado_para_encantamento(encantamento)
    CalculoEncantamento.new(
      forma: encantamento.forma,
      transmutacaos: encantamento.transmutacaos,
      modificadores: encantamento.modificadors
    ).calcular
  end
end