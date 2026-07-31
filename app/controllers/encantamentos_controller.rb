class EncantamentosController < ApplicationController
  before_action :set_personagem
  before_action :carregar_opcoes

  def new
    @encantamento = @personagem.encantamentos.new
    @modificador_ids_selecionados = []
    @resultado = nil
  end

  def create
    @encantamento = @personagem.encantamentos.new(encantamento_params)

    if @encantamento.save
      modificador_ids_atuais.each_with_index do |mod_id, index|
        @encantamento.encantamento_modificadors.create!(modificador_id: mod_id, ordem: index)
      end
      @encantamento.recalcular!
      redirect_to personagem_path(@personagem), notice: "Encantamento salvo com sucesso!"
    else
      @modificador_ids_selecionados = modificador_ids_atuais
      @resultado = calcular_resultado
      render :new, status: :unprocessable_entity
    end
  end

  def preview
    @encantamento = @personagem.encantamentos.new(encantamento_params)
    @modificador_ids_selecionados = modificador_ids_atuais
    @resultado = calcular_resultado

    respond_to { |format| format.turbo_stream }
  end

  private

  def set_personagem
    @personagem = Personagem.find(params[:personagem_id])
  end

  def carregar_opcoes
    @formas = Forma.order(:nome)
    @transmutacaos = Transmutacao.order(:nome)
    @modificadors = Modificador.order(:nome)
  end

  def encantamento_params
    params.require(:encantamento).permit(:nome, :forma_id, :transmutacao_id)
  end

  # A lista ja adicionada viaja como hidden fields (echo do estado atual).
  # novo_modificador_id/remover_modificador_id so vem preenchido quando o
  # botao correspondente foi o clicado.
  def modificador_ids_atuais
    existentes = Array(params[:modificador_ids]).reject(&:blank?)
    existentes += [params[:novo_modificador_id]] if params[:novo_modificador_id].present?
    existentes -= [params[:remover_modificador_id]] if params[:remover_modificador_id].present?
    existentes
  end

  def calcular_resultado
    forma = Forma.find_by(id: encantamento_params[:forma_id])
    transmutacao = Transmutacao.find_by(id: encantamento_params[:transmutacao_id])
    return nil unless forma && transmutacao

    ids = modificador_ids_atuais
    por_id = Modificador.where(id: ids).index_by { |m| m.id.to_s }
    modificadores = ids.map { |id| por_id[id] }.compact # preserva a ordem dos ids

    CalculoEncantamento.new(forma: forma, transmutacao: transmutacao, modificadores: modificadores).calcular
  end
end