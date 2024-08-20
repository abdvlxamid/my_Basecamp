require "test_helper"

class MyAdminProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_admin_projects_index_url
    assert_response :success
  end
end
