require 'test_helper'

class CadEmailsControllerTest < ActionController::TestCase
  setup do
    @cad_email = cad_emails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cad_emails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cad_email" do
    assert_difference('CadEmail.count') do
      post :create, cad_email: { email: @cad_email.email, senha_email: @cad_email.senha_email, senha_skype: @cad_email.senha_skype, skype: @cad_email.skype }
    end

    assert_redirected_to cad_email_path(assigns(:cad_email))
  end

  test "should show cad_email" do
    get :show, id: @cad_email
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cad_email
    assert_response :success
  end

  test "should update cad_email" do
    patch :update, id: @cad_email, cad_email: { email: @cad_email.email, senha_email: @cad_email.senha_email, senha_skype: @cad_email.senha_skype, skype: @cad_email.skype }
    assert_redirected_to cad_email_path(assigns(:cad_email))
  end

  test "should destroy cad_email" do
    assert_difference('CadEmail.count', -1) do
      delete :destroy, id: @cad_email
    end

    assert_redirected_to cad_emails_path
  end
end
