require 'test_helper'

class MonthlyAccountsControllerTest < ActionController::TestCase
  setup do
    @monthly_account = monthly_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monthly_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create monthly_account" do
    assert_difference('MonthlyAccount.count') do
      post :create, monthly_account: { description: @monthly_account.description, due_date: @monthly_account.due_date }
    end

    assert_redirected_to monthly_account_path(assigns(:monthly_account))
  end

  test "should show monthly_account" do
    get :show, id: @monthly_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @monthly_account
    assert_response :success
  end

  test "should update monthly_account" do
    patch :update, id: @monthly_account, monthly_account: { description: @monthly_account.description, due_date: @monthly_account.due_date }
    assert_redirected_to monthly_account_path(assigns(:monthly_account))
  end

  test "should destroy monthly_account" do
    assert_difference('MonthlyAccount.count', -1) do
      delete :destroy, id: @monthly_account
    end

    assert_redirected_to monthly_accounts_path
  end
end
