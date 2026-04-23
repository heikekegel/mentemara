require "test_helper"

class IntakeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get intake_new_url
    assert_response :success
  end

  test "should get create" do
    get intake_create_url
    assert_response :success
  end
end
