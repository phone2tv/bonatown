require 'test_helper'

class EmployerLiabilityItemsControllerTest < ActionController::TestCase
  setup do
    @employer_liability_item = employer_liability_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employer_liability_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employer_liability_item" do
    assert_difference('EmployerLiabilityItem.count') do
      post :create, employer_liability_item: { aggregate_limit: @employer_liability_item.aggregate_limit, bodily_injury_aggregate_limit: @employer_liability_item.bodily_injury_aggregate_limit, bodily_injury_limit: @employer_liability_item.bodily_injury_limit, business_nature: @employer_liability_item.business_nature, deductibles: @employer_liability_item.deductibles, each_accident_limit: @employer_liability_item.each_accident_limit, effective_date: @employer_liability_item.effective_date, employee_number: @employer_liability_item.employee_number, litigation_costs_limit: @employer_liability_item.litigation_costs_limit, medical_expenses_limit: @employer_liability_item.medical_expenses_limit, property_deductibles: @employer_liability_item.property_deductibles, termination_date: @employer_liability_item.termination_date }
    end

    assert_redirected_to employer_liability_item_path(assigns(:employer_liability_item))
  end

  test "should show employer_liability_item" do
    get :show, id: @employer_liability_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employer_liability_item
    assert_response :success
  end

  test "should update employer_liability_item" do
    patch :update, id: @employer_liability_item, employer_liability_item: { aggregate_limit: @employer_liability_item.aggregate_limit, bodily_injury_aggregate_limit: @employer_liability_item.bodily_injury_aggregate_limit, bodily_injury_limit: @employer_liability_item.bodily_injury_limit, business_nature: @employer_liability_item.business_nature, deductibles: @employer_liability_item.deductibles, each_accident_limit: @employer_liability_item.each_accident_limit, effective_date: @employer_liability_item.effective_date, employee_number: @employer_liability_item.employee_number, litigation_costs_limit: @employer_liability_item.litigation_costs_limit, medical_expenses_limit: @employer_liability_item.medical_expenses_limit, property_deductibles: @employer_liability_item.property_deductibles, termination_date: @employer_liability_item.termination_date }
    assert_redirected_to employer_liability_item_path(assigns(:employer_liability_item))
  end

  test "should destroy employer_liability_item" do
    assert_difference('EmployerLiabilityItem.count', -1) do
      delete :destroy, id: @employer_liability_item
    end

    assert_redirected_to employer_liability_items_path
  end
end
