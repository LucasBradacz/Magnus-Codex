require "test_helper"

class EncantamentosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get encantamentos_index_url
    assert_response :success
  end

  test "should get show" do
    get encantamentos_show_url
    assert_response :success
  end
end
