require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get update_resource" do
    get registrations_update_resource_url
    assert_response :success
  end
end
