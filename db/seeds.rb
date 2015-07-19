10.times do |i|
  User.create(name: "test_seed#{i}", participation: "TECH::CAMP #{i}", occupation: "Mentor", profile: "seed test", email: "test+seed#{i}@test.com", password: "12121212")
end