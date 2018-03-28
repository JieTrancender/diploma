require 'test_helper'

class Api::V1::StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
  	get api_v1_static_pages_home_url
  	assert_response :success
  	# assert_match "title", "Home | Ruby on Rails Tutorial Sample App"
  	# assert_equal ActiveSupport::JSON.decode response.body [:title], "Home | Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
  	get api_v1_static_pages_help_url
  	assert_response :success
  end

  test "should get about" do
  	get api_v1_static_pages_about_url
  	assert_response :success
  end
end
