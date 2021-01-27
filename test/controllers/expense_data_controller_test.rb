require 'test_helper'

class ExpenseDataControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get expense_data_new_url
    assert_response :success
  end

end
