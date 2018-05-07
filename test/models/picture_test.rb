require 'test_helper'

class PictureTest < ActiveSupport::TestCase
	def setup
		@user = users(:michael)
		# @picture = Picture.new(key: "avatar.img", url: "localhost/image/avatar.img", user_id: @user.id)
		@picture = @user.pictures.build(key: "avatar.img", url: "localhost/image/avatar.img")
	end

	test "should be valid" do
		assert @picture.valid?
	end

	test "user id should be present" do
		@picture.user_id = nil
		assert_not @picture.valid?
	end

	test "key should be present" do
		@picture.key = "   "
		assert_not @picture.valid?
	end

	test "url should be present" do
		@picture.url = " "
		assert_not @picture.valid?
	end

	test "key should be at most 40 characters" do
		@picture.key = "a" * 41
		assert_not @picture.valid?
	end

	test "url should be at most 160 characters" do
		@picture.url = "a" * 161
		assert_not @picture.valid?
	end

	test "order should be most recent first" do
		assert_equal pictures(:most_recent), Picture.first
	end

	test "associated pictures should be destroyed" do
		@user.pictures.create!(key: "test.img", url: "localhost/image/test.img")
		assert_difference "Picture.count", -1 do
			puts Picture.count
			@user.destroy
			puts Picture.count
		end
	end
end
