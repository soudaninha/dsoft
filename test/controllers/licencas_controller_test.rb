require 'test_helper'

class LicencasControllerTest < ActionController::TestCase
  setup do
    @licenca = licencas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:licencas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create licenca" do
    assert_difference('Licenca.count') do
      post :create, licenca: { patrimonio_id: @licenca.patrimonio_id, produto: @licenca.produto, serial: @licenca.serial }
    end

    assert_redirected_to licenca_path(assigns(:licenca))
  end

  test "should show licenca" do
    get :show, id: @licenca
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @licenca
    assert_response :success
  end

  test "should update licenca" do
    patch :update, id: @licenca, licenca: { patrimonio_id: @licenca.patrimonio_id, produto: @licenca.produto, serial: @licenca.serial }
    assert_redirected_to licenca_path(assigns(:licenca))
  end

  test "should destroy licenca" do
    assert_difference('Licenca.count', -1) do
      delete :destroy, id: @licenca
    end

    assert_redirected_to licencas_path
  end
end
