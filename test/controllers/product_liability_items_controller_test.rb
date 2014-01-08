require 'test_helper'

class ProductLiabilityItemsControllerTest < ActionController::TestCase
  setup do
    @product_liability_item = product_liability_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_liability_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_liability_item" do
    assert_difference('ProductLiabilityItem.count') do
      post :create, product_liability_item: { aggregate_limit: @product_liability_item.aggregate_limit, bodily_injury_limit: @product_liability_item.bodily_injury_limit, business_nature: @product_liability_item.business_nature, each_accident_limit: @product_liability_item.each_accident_limit, property_damage_limit: @product_liability_item.property_damage_limit, started_at: @product_liability_item.started_at, stopped_at: @product_liability_item.stopped_at }
    end

    assert_redirected_to product_liability_item_path(assigns(:product_liability_item))
  end

  test "should show product_liability_item" do
    get :show, id: @product_liability_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_liability_item
    assert_response :success
  end

  test "should update product_liability_item" do
    patch :update, id: @product_liability_item, product_liability_item: { aggregate_limit: @product_liability_item.aggregate_limit, bodily_injury_limit: @product_liability_item.bodily_injury_limit, business_nature: @product_liability_item.business_nature, each_accident_limit: @product_liability_item.each_accident_limit, property_damage_limit: @product_liability_item.property_damage_limit, started_at: @product_liability_item.started_at, stopped_at: @product_liability_item.stopped_at }
    assert_redirected_to product_liability_item_path(assigns(:product_liability_item))
  end

  test "should destroy product_liability_item" do
    assert_difference('ProductLiabilityItem.count', -1) do
      delete :destroy, id: @product_liability_item
    end

    assert_redirected_to product_liability_items_path
  end
end
