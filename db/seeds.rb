## TRUNCATE BY SQL
# SET FOREIGN_KEY_CHECKS = 0; -- Disable foreign key checking.
# TRUNCATE TABLE prototypes;
# TRUNCATE TABLE thumbnails;
# TRUNCATE TABLE users;
# SET FOREIGN_KEY_CHECKS = 1; -- Enable foreign key checking.

# seed data other than tags
# 10.times do |i|
#   i += 1
#   user = User.where(name: "test_seed#{i}", position: "TECH::CAMP-Term#{i}", occupation: "Mentor", profile: "seed test", email: "test+seed#{i}@test.com", encrypted_password: "12121212", avatar: open("#{Rails.root}/app/assets/images/noimage.png")).first_or_create
#   proto = Prototype.where(title: "test_seed#{i}", copy: "No.#{i} Awesome App", concept: "This app(No.#{i}) is created for ymtSpace", user_id: user.id).first_or_create
#   Thumbnail.where(thumbnail: open("#{Rails.root}/app/assets/images/noimage.png"), role: 0, prototype_id: proto.id).first_or_create
#   Thumbnail.where(thumbnail: open("#{Rails.root}/app/assets/images/noimage.png"), role: 1, prototype_id: proto.id).first_or_create
# end

# seed data only for tags
# Prototype.all.each do |proto|
#   proto.tag_list = ["tag-test1", "tag-test2", "tag-test3"]
#   proto.save
# end

# seed data for comments
# Prototype.all.each do |proto|
#   5.times do |i|
#     i += 1
#     user = User.find(i)
#     proto.comments.create(user_id: user.id, text: "this is no.#{i} comment only for test")
#   end
# end
