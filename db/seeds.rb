# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create!(
	name: "JTrancender", email: "jie-email@jie-trancender.org",
	password: "jason@jing.com",
	password_confirmation: "jason@jing.com",
	admin: true,
	activated: true,
	activated_at: Time.zone.now
)

User.create!(
	name: "Jane",
	email: 'jane-email@jie-trancender.org',
	password: "jason@jing.com",
	password_confirmation: "jason@jing.com",
	admin: true,
	activated: true,
	activated_at: Time.zone.now
)

400.times do |n|
	User.create!(
		name: Faker::Name.name,
		email: "example-#{n + 1}@example.com",
		password: "password",
		password_confirmation: "password",
		activated: true,
		activated_at: Time.zone.now
	)
end

	# Microposts
users = User.order(:created_at).take(6)

# url = %w(http://sources.jie-trancender.org/image/wechat/search.png?imageView2/2/w/320/h/480 http://sources.jie-trancender.org/images/fetch/bdlogo.png?imageView2/2/w/320/h/480 http://sources.jie-trancender.org/images/img_qiniu.jpg?imageView2/2/w/320/h/480 http://sources.jie-trancender.org/images/java-qiniu/my-logo.jpg?imageView2/2/w/320/h/480 http://sources.jie-trancender.org/images/qiniu-linux-cmd.txt?imageView2/2/w/320/h/480 http://sources.jie-trancender.org/images/ruby-qiniu/my-ruby-logo.jpg?imageView2/2/w/320/h/480 http://sources.jie-trancender.org/images/t_vip_lua.png?imageView2/2/w/320/h/480 http://sources.jie-trancender.org/images/t_vip_mysql.png?imageView2/2/w/320/h/480 http://sources.jie-trancender.org/images/wechat/search.png?imageView2/2/w/320/h/480)

url = %w(http://sources.jie-trancender.org/images/img_qiniu.jpg?imageView2/2/w/320/h/480)

50.times do
	content = Faker::Lorem.sentence(5)
	users.each do |user|
		user.microposts.create!(content: content)
	end

	users.each do |user|
		singleUrl = url.sample
		key = singleUrl.split('/')[-1]
		user.pictures.create!(key: 'img_qiniu.jpg', url: singleUrl)
	end
end

# Following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each do |followed|
	user.follow(followed)
end

followers.each do |follower|
	follower.follow(user)
end