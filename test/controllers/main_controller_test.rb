require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get menu" do
    get main_menu_url
    assert_response :success
  end
end
