require 'test_helper'

class PatrimoniosControllerTest < ActionController::TestCase
  setup do
    @patrimonio = patrimonios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:patrimonios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create patrimonio" do
    assert_difference('Patrimonio.count') do
      post :create, patrimonio: { ad_user_id: @patrimonio.ad_user_id, descricao: @patrimonio.descricao, numero_patrimonio: @patrimonio.numero_patrimonio }
    end

    assert_redirected_to patrimonio_path(assigns(:patrimonio))
  end

  test "should show patrimonio" do
    get :show, id: @patrimonio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @patrimonio
    assert_response :success
  end

  test "should update patrimonio" do
    patch :update, id: @patrimonio, patrimonio: { ad_user_id: @patrimonio.ad_user_id, descricao: @patrimonio.descricao, numero_patrimonio: @patrimonio.numero_patrimonio }
    assert_redirected_to patrimonio_path(assigns(:patrimonio))
  end

  test "should destroy patrimonio" do
    assert_difference('Patrimonio.count', -1) do
      delete :destroy, id: @patrimonio
    end

    assert_redirected_to patrimonios_path
  end
end
