#users
User.create!(name: "test",
    email: "test@test.com", 
    password: "qwe123bnm", 
    password_confirmation: "qwe123bnm", 
    admin: true, 
    activated: true, 
    activated_at: Time.zone.now)

9.times do |n|
    name = Faker::Name.name 
    email = "test#{n+2}@test.com"
    password = "qwe123bnm"
    User.create!(name: name, 
        email: email, 
        password: password, 
        password_confirmation: password,
        activated: true,
        activated_at: Time.zone.now,
    )
end  


#microposts
users = User.order(:created_at).take(5)
5.times do 
    content = Faker::Lorem.sentence(word_count: 5)
    users.each { |user| 
        micropost = user.microposts.create!(content: content)
        micropost.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'rails.png')), filename: 'rails.png', content_type: 'image/png')
    }
end   

#follow
users = User.all
user = users.first
following = users[2..5]
followers = users[2..5]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }