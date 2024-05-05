namespace :db do
  desc 'Create 4 users'
  task create_users: :environment do
    4.times do |i|
      user = User.create!(id: i + 1,  username: "user#{i + 1}")
    end
  end

  desc 'Create posts' #optional
  task create_posts: :environment do
    user_1 = User.first
    user_2 = User.second
    user_3 = User.third
    user_4 = User.fourth

    10.times do |i|
      Timecop.freeze(Date.today - i.days) do
        Post.create!(user: user_1 , content: "Post content #{i + 1}")
        Post.create!(user: user_2 , content: "Post content #{i + 1}")
        Post.create!(user: user_3 , content: "Post content #{i + 1}")
        Post.create!(user: user_4 , content: "Post content #{i + 1}")
      end
    end
  end
end
