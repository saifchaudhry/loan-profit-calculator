require "test_helper"

class LoanProfitControllerTest < ActionDispatch::IntegrationTest
  test "should get calculate_profit" do
    get loan_profit_create_url
    assert_response :success
  end

  test "should get new" do
    get loan_profit_new_url
    assert_response :success
  end
end
