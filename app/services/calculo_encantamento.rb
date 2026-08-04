# frozen_string_literal: true

# app/services/calculo_encantamento.rb
class CalculoEncantamento
  Resultado = Struct.new(
    :custo_final, :qtd_dados, :dado_poder, :poder_formatado,
    :divisoes_poder, :efeitos, :alcance, :tamanho, :duracao,
    keyword_init: true
  )

  def initialize(forma:, transmutacao:, modificadores: [])
    @forma = forma
    @transmutacao = transmutacao
    @modificadores = modificadores # já na ordem escolhida pelo jogador
  end

  def calcular
    Resultado.new(
      custo_final: calcular_custo,
      qtd_dados: qtd_dados_final,
      dado_poder: @transmutacao.dado_poder,
      poder_formatado: "#{qtd_dados_final}#{@transmutacao.dado_poder}",
      divisoes_poder: divisoes_poder_pendentes,
      efeitos: efeitos_completos,
      alcance: @forma.alcance,
      tamanho: @forma.tamanho,
      duracao: @forma.duracao.presence || "Indeterminado"
    )
  end

  private

  def efeitos_completos
    lista = []
    lista << @transmutacao.descricao if @transmutacao.descricao.present?
    lista.concat(@modificadores.filter_map(&:descricao))
    lista.uniq
  end

  # Custo: parte do custo_base da Forma, aplica cada modificador EM ORDEM,
  # só no final multiplica pelo custo_multiplicador da Transmutação.
  def calcular_custo
    custo = @modificadores.reduce(@forma.custo_base.to_f) do |acumulado, mod|
      aplicar_operacao(acumulado, mod.operacao_custo, mod.valor_custo)
    end

    custo *= (@transmutacao.custo_multiplicador || 1)
    arredondar(custo)
  end

  # Quantidade de dados: só entram operações de poder que NÃO são divisão
  # (divisão é tratada à parte, depois da rolagem real).
  def qtd_dados_final
    poder = @modificadores.reduce(@forma.poder_base.to_f) do |acumulado, mod|
      next acumulado if mod.operacao_poder.nil?
      next acumulado if mod.operacao_poder == "divisao"

      aplicar_operacao(acumulado, mod.operacao_poder, mod.valor_poder)
    end

    arredondar(poder)
  end

  def divisoes_poder_pendentes
    @modificadores
      .select { |mod| mod.operacao_poder == "divisao" }
      .map(&:valor_poder)
  end

  def aplicar_operacao(valor, operacao, quantidade)
    case operacao
    when "soma" then valor + quantidade
    when "subtracao" then valor - quantidade
    when "multiplicacao" then valor * quantidade
    when "divisao" then valor / quantidade
    else valor
    end
  end

  # Regra: "todo decimal arredondado para baixo (mínimo 1)"
  def arredondar(valor)
    [valor.floor, 1].max
  end
end