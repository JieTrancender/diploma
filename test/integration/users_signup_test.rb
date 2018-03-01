require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
  	get signup_path
  	assert_no_difference 'User.count' do
  		post users_path, params: {
  			user: {
  				name: '',
  				email: 'user@invalid',
  				password: 'test',
  				password_confirmation: 'test'
  			}
  		}
  	end
  	assert_template 'users/new'
  	assert_select 'div#error_explanation'
  end

  test "valid signup information" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		post signup_path, params: {
  			user: {
  				name: 'Example User',
  				email: 'user@example.com',
  				password: 'password',
  				password_confirmation: 'password'
  			}
  		}
  	end
  	follow_redirect!
  	assert_template 'users/show'
  	assert is_logged_in?
  	assert_select 'div.alert-success'
  	assert_select 'div.alert-success', 'Welcome to the Sample App!'
  end
end
