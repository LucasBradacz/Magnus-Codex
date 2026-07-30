# test/services/encantamento_calculadora_test.rb
require "test_helper"

class CalculoEncantamentoTest < ActiveSupport::TestCase
  def forma(custo_base: 10, poder_base: 2)
    Forma.new(nome: "Forma Teste", custo_base: custo_base, poder_base: poder_base)
  end

  def transmutacao(dado_poder: "d8", custo_multiplicador: 1)
    Transmutacao.new(nome: "Transmutacao Teste", dado_poder: dado_poder, custo_multiplicador: custo_multiplicador)
  end

  def modificador(operacao_custo: "soma", valor_custo: 0, operacao_poder: nil, valor_poder: nil, efeito: nil)
    Modificador.new(
      nome: "Modificador Teste",
      operacao_custo: operacao_custo,
      valor_custo: valor_custo,
      operacao_poder: operacao_poder,
      valor_poder: valor_poder,
      efeito: efeito
    )
  end

  test "sem modificadores, poder e custo vem direto da forma e transmutacao" do
    resultado = CalculoEncantamento.new(
      forma: forma(custo_base: 10, poder_base: 2),
      transmutacao: transmutacao(dado_poder: "d8", custo_multiplicador: 2),
      modificadores: []
    ).calcular

    assert_equal 20, resultado.custo_final # 10 * 2
    assert_equal "2d8", resultado.poder_formatado
    assert_empty resultado.divisoes_poder
    assert_empty resultado.efeitos
  end

  test "modificadores de custo sao aplicados em ordem antes do multiplicador da transmutacao" do
    mods = [
      modificador(operacao_custo: "soma", valor_custo: 5),        # 10 + 5 = 15
      modificador(operacao_custo: "multiplicacao", valor_custo: 2) # 15 * 2 = 30
    ]

    resultado = EncantamentoCalculadora.new(
      forma: forma(custo_base: 10),
      transmutacao: transmutacao(custo_multiplicador: 3), # 30 * 3 = 90
      modificadores: mods
    ).calcular

    assert_equal 90, resultado.custo_final
  end

  test "operacao de poder que nao seja divisao afeta a quantidade de dados" do
    mods = [modificador(operacao_poder: "soma", valor_poder: 3)] # 2 + 3 = 5

    resultado = EncantamentoCalculadora.new(
      forma: forma(poder_base: 2),
      transmutacao: transmutacao(dado_poder: "d6"),
      modificadores: mods
    ).calcular

    assert_equal "5d6", resultado.poder_formatado
    assert_empty resultado.divisoes_poder
  end

  test "divisao de poder nao entra na quantidade de dados, fica pendente pra depois da rolagem" do
    mods = [
      modificador(operacao_poder: "soma", valor_poder: 2),    # 2 + 2 = 4 (entra na rolagem)
      modificador(operacao_poder: "divisao", valor_poder: 2)  # nao entra, fica pendente
    ]

    resultado = EncantamentoCalculadora.new(
      forma: forma(poder_base: 2),
      transmutacao: transmutacao(dado_poder: "d10"),
      modificadores: mods
    ).calcular

    assert_equal "4d10", resultado.poder_formatado
    assert_equal [2], resultado.divisoes_poder
  end

  test "modificador com operacao_poder nula nao afeta o poder" do
    mods = [modificador(operacao_poder: nil, valor_poder: nil)]

    resultado = EncantamentoCalculadora.new(
      forma: forma(poder_base: 3),
      transmutacao: transmutacao(dado_poder: "d4"),
      modificadores: mods
    ).calcular

    assert_equal "3d4", resultado.poder_formatado
  end

  test "resultado decimal e sempre arredondado para baixo, minimo 1" do
    mods = [modificador(operacao_custo: "divisao", valor_custo: 4)] # 10 / 4 = 2.5 -> 2

    resultado = EncantamentoCalculadora.new(
      forma: forma(custo_base: 10),
      transmutacao: transmutacao(custo_multiplicador: 1),
      modificadores: mods
    ).calcular

    assert_equal 2, resultado.custo_final
  end

  test "custo minimo e 1 mesmo se o calculo zerar ou ficar negativo" do
    mods = [modificador(operacao_custo: "subtracao", valor_custo: 999)]

    resultado = EncantamentoCalculadora.new(
      forma: forma(custo_base: 10),
      transmutacao: transmutacao(custo_multiplicador: 1),
      modificadores: mods
    ).calcular

    assert_equal 1, resultado.custo_final
  end

  test "apenas modificadores com efeito preenchido aparecem na lista de efeitos" do
    mods = [
      modificador(efeito: "Ignora resistencia magica"),
      modificador(efeito: nil),
      modificador(efeito: "Empurra o alvo 2m")
    ]

    resultado = EncantamentoCalculadora.new(
      forma: forma,
      transmutacao: transmutacao,
      modificadores: mods
    ).calcular

    assert_equal ["Ignora resistencia magica", "Empurra o alvo 2m"], resultado.efeitos
  end

  test "ordem dos modificadores de custo importa no resultado" do
    soma = modificador(operacao_custo: "soma", valor_custo: 10)
    multiplicacao = modificador(operacao_custo: "multiplicacao", valor_custo: 2)

    ordem_a = EncantamentoCalculadora.new(
      forma: forma(custo_base: 5),
      transmutacao: transmutacao,
      modificadores: [soma, multiplicacao] # (5 + 10) * 2 = 30
    ).calcular

    ordem_b = EncantamentoCalculadora.new(
      forma: forma(custo_base: 5),
      transmutacao: transmutacao,
      modificadores: [multiplicacao, soma] # (5 * 2) + 10 = 20
    ).calcular

    refute_equal ordem_a.custo_final, ordem_b.custo_final
    assert_equal 30, ordem_a.custo_final
    assert_equal 20, ordem_b.custo_final
  end
end