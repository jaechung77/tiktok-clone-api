# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user = User.create(email: "jaechung77@daum.net", password: "12341234", first_name: "Jae", last_name: "Chung", nick_name: "JChung")

# post = Post.create(title: "test", content: "content", video_url:"http://localhost:4000", likes: 100, viewer:1, comment_flag: true, user_id:1)
# hashtag1 = Hashtag.create(post_id: 1, tag: "#test")
# hashtag2 = Hashtag.create(post_id: 1, tag: "#testtest")
# hashtag3 = Hashtag.create(post_id: 1, tag: "#testtesttest")

comment = Comment.create(comment: "comment test", post_id: 1)