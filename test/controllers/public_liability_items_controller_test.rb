require 'test_helper'

class PublicLiabilityItemsControllerTest < ActionController::TestCase
  setup do
    @public_liability_item = public_liability_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:public_liability_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create public_liability_item" do
    assert_difference('PublicLiabilityItem.count') do
      post :create, public_liability_item: { business_place: @public_liability_item.business_place, business_type: @public_liability_item.business_type, insurance_id: @public_liability_item.insurance_id, with_fire_control: @public_liability_item.with_fire_control, with_security_measure: @public_liability_item.with_security_measure }
    end

    assert_redirected_to public_liability_item_path(assigns(:public_liability_item))
  end

  test "should show public_liability_item" do
    get :show, id: @public_liability_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @public_liability_item
    assert_response :success
  end

  test "should update public_liability_item" do
    patch :update, id: @public_liability_item, public_liability_item: { business_place: @public_liability_item.business_place, business_type: @public_liability_item.business_type, insurance_id: @public_liability_item.insurance_id, with_fire_control: @public_liability_item.with_fire_control, with_security_measure: @public_liability_item.with_security_measure }
    assert_redirected_to public_liability_item_path(assigns(:public_liability_item))
  end

  test "should destroy public_liability_item" do
    assert_difference('PublicLiabilityItem.count', -1) do
      delete :destroy, id: @public_liability_item
    end

    assert_redirected_to public_liability_items_path
  end
end
