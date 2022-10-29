User.create!(name: "test",
    email: "test@test.com", 
    password: "qwe123bnm", 
    password_confirmation: "qwe123bnm", 
    admin: true, 
    activated: true, 
    activated_at: Time.zone.now)

9.times do |n|
    name = Faker::Name.name 
    email = "test#{n+1}@test.com"
    password = "qwe123bnm"
    User.create!(name: name, 
        email: email, 
        password: password, 
        password_confirmation: password,
        activated: true,
        activated_at: Time.zone.now,
    )
end  

users = User.order(:created_at).take(5)
5.times do 
    content = Faker::Lorem.sentence(word_count: 5)
    users.each { |user| user.microposts.create!(content: content) }
end   