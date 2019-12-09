User.create name: "admin", email: "admin@mail.com", role: "admin", password: "123456", confirmed_at: DateTime.now

10.times do |i|
  User.create name: Faker::Name.name_with_middle, email: "founder#{i}@mail.com", role: "founder", password: "123456", confirmed_at: DateTime.now
end

500.times do |i|
  User.create name: Faker::Name.name_with_middle, email: "member#{i}@mail.com", password: "123456", confirmed_at: DateTime.now
end

#create category

Category.create name: "Education"
Category.create name: "Healthy"
Category.create name: "Environment"
Category.create name: "Society"
Category.create name: "Homeless"
Category.create name: "Other"

#create causes
User.founder.each do |u|
  (Faker::Number.between(from: 10, to: 15)).times do
    u.causes.create title: Faker::Lorem.paragraph( supplemental: true),
                    detail: Faker::Lorem.paragraph_by_chars(number: 1500, supplemental: true),
                    end_time: Faker::Date.between_except(from: 1.month.from_now, to: 1.year.from_now, excepted: Date.today),
                    goal_money: Faker::Number.between(from: 5000, to: 10000),
                    reached_money: Faker::Number.between(from: 100, to: 4900),
                    category_id: Faker::Number.between(from: 1, to: 6)
  end
end

#create event, blog, donation
Cause.all.each do |c|

  (Faker::Number.between(from:2, to: 5)).times do
    c.events.create title: Faker::Lorem.paragraph(supplemental: true),
                    content: Faker::Lorem.paragraph_by_chars(number: 1500, supplemental: true),
                    place: Faker::Address.full_address,
                    total_person: Faker::Number.between(from: 30, to: 99),
                    expiration_date: Faker::Date.between_except(from: 1.month.from_now, to: 2.month.from_now, excepted: Date.today),
                    start_time: Faker::Date.between_except(from: 2.month.from_now, to: 3.month.from_now, excepted: 2.month.from_now),
                    end_time: Faker::Date.between_except(from: 3.month.from_now, to: 4.month.from_now, excepted: 4.month.from_now),
                    category_id: c.category_id
  end

  (Faker::Number.between(from:1, to: 4)).times do
    c.blogs.create title: Faker::Lorem.paragraph(supplemental: true),
                   content: Faker::Lorem.paragraph_by_chars(number: 1500, supplemental: true),
                   category_id: c.category_id
  end

  (Faker::Number.between(from:100, to: 300)).times do
    c.donations.create amount: Faker::Number.decimal(l_digits: 2, r_digits: 2),
                       user_id: Faker::Number.between(from: 12, to: 500),
                       description: Faker::Lorem.sentence(supplemental: true),
                       purchased_at: Faker::Time.between_dates(from: c.created_at, to: c.end_time)
  end
end

Tag.create name: "education"
Tag.create name: "homeless"
Tag.create name: "healthy"
Tag.create name: "support"


