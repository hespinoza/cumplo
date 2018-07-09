require 'test_helper'

class TmcControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tmc_index_url
    assert_response :success
  end

end
