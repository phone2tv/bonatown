require 'test_helper'

class AccidentItemsControllerTest < ActionController::TestCase
  setup do
    @accident_item = accident_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accident_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accident_item" do
    assert_difference('AccidentItem.count') do
      post :create, accident_item: { accident_insurance_id: @accident_item.accident_insurance_id, employee_number: @accident_item.employee_number, industry_id: @accident_item.industry_id }
    end

    assert_redirected_to accident_item_path(assigns(:accident_item))
  end

  test "should show accident_item" do
    get :show, id: @accident_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accident_item
    assert_response :success
  end

  test "should update accident_item" do
    patch :update, id: @accident_item, accident_item: { accident_insurance_id: @accident_item.accident_insurance_id, employee_number: @accident_item.employee_number, industry_id: @accident_item.industry_id }
    assert_redirected_to accident_item_path(assigns(:accident_item))
  end

  test "should destroy accident_item" do
    assert_difference('AccidentItem.count', -1) do
      delete :destroy, id: @accident_item
    end

    assert_redirected_to accident_items_path
  end
end
