require 'test_helper'

class HeritagesControllerTest < ActionController::TestCase
  setup do
    @heritage = heritages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:heritages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create heritage" do
    assert_difference('Heritage.count') do
      post :create, heritage: { client_id: @heritage.client_id, description: @heritage.description, type_contract: @heritage.type_contract }
    end

    assert_redirected_to heritage_path(assigns(:heritage))
  end

  test "should show heritage" do
    get :show, id: @heritage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @heritage
    assert_response :success
  end

  test "should update heritage" do
    patch :update, id: @heritage, heritage: { client_id: @heritage.client_id, description: @heritage.description, type_contract: @heritage.type_contract }
    assert_redirected_to heritage_path(assigns(:heritage))
  end

  test "should destroy heritage" do
    assert_difference('Heritage.count', -1) do
      delete :destroy, id: @heritage
    end

    assert_redirected_to heritages_path
  end
end
