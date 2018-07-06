require 'test_helper'

class IndicatorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get indicator_index_url
    assert_response :success
  end

end
