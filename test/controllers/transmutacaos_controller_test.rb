require "test_helper"

class TransmutacaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transmutacao = transmutacaos(:one)
  end

  test "should get index" do
    get transmutacaos_url
    assert_response :success
  end

  test "should get new" do
    get new_transmutacao_url
    assert_response :success
  end

  test "should create transmutacao" do
    assert_difference("Transmutacao.count") do
      post transmutacaos_url, params: { transmutacao: { custo_multiplicador: @transmutacao.custo_multiplicador, dado_poder: @transmutacao.dado_poder, descricao: @transmutacao.descricao, nome: @transmutacao.nome } }
    end

    assert_redirected_to transmutacao_url(Transmutacao.last)
  end

  test "should show transmutacao" do
    get transmutacao_url(@transmutacao)
    assert_response :success
  end

  test "should get edit" do
    get edit_transmutacao_url(@transmutacao)
    assert_response :success
  end

  test "should update transmutacao" do
    patch transmutacao_url(@transmutacao), params: { transmutacao: { custo_multiplicador: @transmutacao.custo_multiplicador, dado_poder: @transmutacao.dado_poder, descricao: @transmutacao.descricao, nome: @transmutacao.nome } }
    assert_redirected_to transmutacao_url(@transmutacao)
  end

  test "should destroy transmutacao" do
    assert_difference("Transmutacao.count", -1) do
      delete transmutacao_url(@transmutacao)
    end

    assert_redirected_to transmutacaos_url
  end
end
