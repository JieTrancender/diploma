require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(nickname: 'JTrancender', email: 'jie-email@jie-trancender.org')
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "nickname should be present" do
  	@user.nickname = "  "
  	assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "nickname is at most 16 characters" do
  	@user.nickname = "a" * 17
  	assert_not @user.valid?
  end

  test "email is at most 140 characters" do
    @user.email = "a" * 141
    assert_not @user.valid?
  end
end
