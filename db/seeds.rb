# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
spring = User.find_or_create_by!(email: "spring@example.com") do |user|
  user.name = "Sakura"
  user.password = "sakura"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
  user.introduction = "カフェ巡りが趣味です♪"
end

summer = User.find_or_create_by!(email: "summer@example.com") do |user|
  user.name = "hana"
  user.password = "hanabi"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
  user.introduction = "よろしくお願いします。"
end

automn = User.find_or_create_by!(email: "automn@example.com") do |user|
  user.name = "秋久"
  user.password = "akihisa"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
  user.introduction = "ぶらり一人旅。"
end

winter = User.find_or_create_by!(email: "winter@example.com") do |user|
  user.name = "ユキ"
  user.password = "yukiyuki"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename:"sample-user4.jpg")
  user.introduction = "たくさん思い出を作りたいです。"
end