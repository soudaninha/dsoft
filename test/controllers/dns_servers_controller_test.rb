require 'test_helper'

class DnsServersControllerTest < ActionController::TestCase
  setup do
    @dns_server = dns_servers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dns_servers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dns_server" do
    assert_difference('DnsServer.count') do
      post :create, dns_server: { client_id: @dns_server.client_id, dns: @dns_server.dns, email: @dns_server.email, password: @dns_server.password }
    end

    assert_redirected_to dns_server_path(assigns(:dns_server))
  end

  test "should show dns_server" do
    get :show, id: @dns_server
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dns_server
    assert_response :success
  end

  test "should update dns_server" do
    patch :update, id: @dns_server, dns_server: { client_id: @dns_server.client_id, dns: @dns_server.dns, email: @dns_server.email, password: @dns_server.password }
    assert_redirected_to dns_server_path(assigns(:dns_server))
  end

  test "should destroy dns_server" do
    assert_difference('DnsServer.count', -1) do
      delete :destroy, id: @dns_server
    end

    assert_redirected_to dns_servers_path
  end
end
