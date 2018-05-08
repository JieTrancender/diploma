require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(nickname: 'JTrancender')
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "nickname should be present" do
  	@user.nickname = "  "
  	assert_not @user.valid?
  end

  test "nickname is at most 16 characters" do
  	@user.nickname = "a" * 17
  	assert_not @user.valid?
  end
end
