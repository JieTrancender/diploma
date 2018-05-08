require 'test_helper'

class UserAuthTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(nickname: 'JTrancender')
  	# @user_auth = @user.user_auths.build(identityType: 'email', identifier: 'jie-test@jie-trancender.org',
  		# password_digest: Digest::MD5.hexdigest('jason@jing.com'))
    @user_auth = @user.user_auths.build(identityType: 'email', identifier: 'jie-test@jie-trancender.org',
      password: 'jason@jing.com', password_confirmation: 'jason@jing.com')
  end


  test "identityType should be present" do
  	@user_auth.identityType = "  "
  	assert_not @user_auth.valid?
  end

  test "identifier should be present" do
  	@user_auth.identifier = nil
  	assert_not @user_auth.valid?
  end

  test "password should be present" do
  	@user_auth.password = @user_auth.password_confirmation = "  "
  	assert_not @user_auth.valid?
  end

  test "identityType is at most 40 characters" do
  	@user_auth.identityType = "a" * 41
  	assert_not @user_auth.valid?
  end

  test "identifier is at most 40 characters" do
  	@user_auth.identifier = "a" * 41
  	assert_not @user_auth.valid?
  end

  test "password is at most 40 characters" do
  	@user_auth.password = @user_auth.password_confirmation = "a" * 41
  	assert_not @user_auth.valid?
  end

  test "identifier should be unique" do
    duplicate_user_auth = @user_auth.dup
    duplicate_user_auth.identifier = @user_auth.identifier.upcase
    @user_auth.save
    assert_not duplicate_user_auth.valid?
  end

  test "identifier should be saved as lower-case" do
    upIdentifier = 'ExamPLE@example.com'
    @user_auth.identifier = upIdentifier
    @user_auth.save
    assert_equal upIdentifier.downcase, @user_auth.reload.identifier
  end

  test "password should have a minimum length" do
    @user_auth.password = @user_auth.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
