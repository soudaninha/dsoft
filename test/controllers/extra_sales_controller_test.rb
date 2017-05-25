require 'test_helper'

class ExtraSalesControllerTest < ActionController::TestCase
  setup do
    @extra_sale = extra_sales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extra_sales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extra_sale" do
    assert_difference('ExtraSale.count') do
      post :create, extra_sale: { client_id: @extra_sale.client_id, due_date: @extra_sale.due_date, obs: @extra_sale.obs, product: @extra_sale.product, value: @extra_sale.value }
    end

    assert_redirected_to extra_sale_path(assigns(:extra_sale))
  end

  test "should show extra_sale" do
    get :show, id: @extra_sale
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extra_sale
    assert_response :success
  end

  test "should update extra_sale" do
    patch :update, id: @extra_sale, extra_sale: { client_id: @extra_sale.client_id, due_date: @extra_sale.due_date, obs: @extra_sale.obs, product: @extra_sale.product, value: @extra_sale.value }
    assert_redirected_to extra_sale_path(assigns(:extra_sale))
  end

  test "should destroy extra_sale" do
    assert_difference('ExtraSale.count', -1) do
      delete :destroy, id: @extra_sale
    end

    assert_redirected_to extra_sales_path
  end
end
