require 'test_helper'

class AdUsersControllerTest < ActionController::TestCase
  setup do
    @ad_user = ad_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ad_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ad_user" do
    assert_difference('AdUser.count') do
      post :create, ad_user: { colaborador: @ad_user.colaborador, departamento: @ad_user.departamento, ip: @ad_user.ip, pastas: @ad_user.pastas, senha: @ad_user.senha, user_ad: @ad_user.user_ad }
    end

    assert_redirected_to ad_user_path(assigns(:ad_user))
  end

  test "should show ad_user" do
    get :show, id: @ad_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ad_user
    assert_response :success
  end

  test "should update ad_user" do
    patch :update, id: @ad_user, ad_user: { colaborador: @ad_user.colaborador, departamento: @ad_user.departamento, ip: @ad_user.ip, pastas: @ad_user.pastas, senha: @ad_user.senha, user_ad: @ad_user.user_ad }
    assert_redirected_to ad_user_path(assigns(:ad_user))
  end

  test "should destroy ad_user" do
    assert_difference('AdUser.count', -1) do
      delete :destroy, id: @ad_user
    end

    assert_redirected_to ad_users_path
  end
end
