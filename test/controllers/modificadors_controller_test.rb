require "test_helper"

class ModificadorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @modificador = modificadors(:one)
  end

  test "should get index" do
    get modificadors_url
    assert_response :success
  end

  test "should get new" do
    get new_modificador_url
    assert_response :success
  end

  test "should create modificador" do
    assert_difference("Modificador.count") do
      post modificadors_url, params: { modificador: { descricao: @modificador.descricao, efeito: @modificador.efeito, nome: @modificador.nome, operacao_custo: @modificador.operacao_custo, operacao_poder: @modificador.operacao_poder, valor_custo: @modificador.valor_custo, valor_poder: @modificador.valor_poder } }
    end

    assert_redirected_to modificador_url(Modificador.last)
  end

  test "should show modificador" do
    get modificador_url(@modificador)
    assert_response :success
  end

  test "should get edit" do
    get edit_modificador_url(@modificador)
    assert_response :success
  end

  test "should update modificador" do
    patch modificador_url(@modificador), params: { modificador: { descricao: @modificador.descricao, efeito: @modificador.efeito, nome: @modificador.nome, operacao_custo: @modificador.operacao_custo, operacao_poder: @modificador.operacao_poder, valor_custo: @modificador.valor_custo, valor_poder: @modificador.valor_poder } }
    assert_redirected_to modificador_url(@modificador)
  end

  test "should destroy modificador" do
    assert_difference("Modificador.count", -1) do
      delete modificador_url(@modificador)
    end

    assert_redirected_to modificadors_url
  end
end
