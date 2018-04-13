require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  def setup
  	@user = users(:michael)
  	# 不符合常见做法
  	# @picture = Picture.new(key: 'test.jpg', url: 'jie-trancender.org/images/test.jpg', user_id: @user.id)
  	@picture = @user.pictures.build(key: 'test.jpg', url: 'jie-trancender.org/images/test.jpg', user_id: @user.id)
  end

  test "should be valid" do
  	assert @picture.valid?
  end

  test "user is should be present" do
  	@picture.user_id = nil
  	assert_not @picture.valid?
  end

  test "key should be present" do
  	@picture.key = "   "
  	assert_not @picture.valid?
  end

  test "url should be at most 255 characters" do
  	@picture.url = 'a' * 256
  	assert_not @picture.valid?
  end

  test "key should be at most 255 characters" do
  	@picture.key = 'a' * 256
  	assert_not @picture.valid?
  end

  test "order should be most recent first" do
  	assert_equal pictures(:most_recent), Picture.first
  end
end
