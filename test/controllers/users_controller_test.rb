require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
		@other_user = users(:archer)
	end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when logged in as wrong user" do
  	log_in_as(@other_user)
  	get edit_user_path(@user)
  	assert flash.empty?
  	assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
  	log_in_as(@other_user)
  	patch user_path(@user), params: {
  		user: {
  			name: @user.name,
  			email: @user.email
  		}
  	}
  	assert flash.empty?
  	assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  # test "should not allow the admin attribute to be edited via the web" do
  #   log_in_as(@other_user)
  #   assert_not @other_user.admin?
  #   patch user_path(@other_user), params: {
  #     user: {
  #       password: 123456,
  #       password_confirmation: 123456,
  #       admin: true
  #     }
  #   }

  #   assert_not @other_user.reload.admin?
  # end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end

    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "can delete" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end

end
