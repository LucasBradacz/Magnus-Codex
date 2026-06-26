require "test_helper"

class FormasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @forma = formas(:one)
  end

  test "should get index" do
    get formas_url
    assert_response :success
  end

  test "should get new" do
    get new_forma_url
    assert_response :success
  end

  test "should create forma" do
    assert_difference("Forma.count") do
      post formas_url, params: { forma: { alcance: @forma.alcance, custo_base: @forma.custo_base, descricao: @forma.descricao, duracao: @forma.duracao, nome: @forma.nome, poder_base: @forma.poder_base, tamanho: @forma.tamanho } }
    end

    assert_redirected_to forma_url(Forma.last)
  end

  test "should show forma" do
    get forma_url(@forma)
    assert_response :success
  end

  test "should get edit" do
    get edit_forma_url(@forma)
    assert_response :success
  end

  test "should update forma" do
    patch forma_url(@forma), params: { forma: { alcance: @forma.alcance, custo_base: @forma.custo_base, descricao: @forma.descricao, duracao: @forma.duracao, nome: @forma.nome, poder_base: @forma.poder_base, tamanho: @forma.tamanho } }
    assert_redirected_to forma_url(@forma)
  end

  test "should destroy forma" do
    assert_difference("Forma.count", -1) do
      delete forma_url(@forma)
    end

    assert_redirected_to formas_url
  end
end
