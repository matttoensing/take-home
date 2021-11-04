# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tea.destroy_all
Subscription.destroy_all
Customer.destroy_all

statuses = [:subscribed, :cancelled, :paused]
frequency = [:weekly, :bi_weekly, :monthly]

5.times do
  customer = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, address: Faker::Address.full_address)
  2.times do
    subscription = Subscription.create!(title: "#{Faker::Tea.type} Subscription", price: Faker::Number.decimal(l_digits: 2), status: statuses.sample, frequency: frequency.sample, customer: customer)
    3.times do
      Tea.create!(title: Faker::Tea.variety, description: Faker::Tea.type, temperature: Faker::Number.decimal(l_digits: 1), brew_time: Faker::Number.between(from: 2, to: 20), subscription: subscription)
    end
  end
end

puts "Created #{Customer.count} customers, #{Subscription.count} subscriptions, and #{Tea.count} teas"
