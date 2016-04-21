# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Rails.env.production?

  puts "### Starting db/seeds.rb ###"
  ActiveRecord::Base.transaction do
    puts "Create Accounts, Divisions, Groups..."
    20.times do |i|
      Account.create(
        email: "opentie#{i}@example.com",
        kibokan_id: 0,
        password: "password",
        password_confirmation: "password"
      )

      Division.create(
        name: "division#{i}"
      )

      Group.create(
        kibokan_id: i
      )
    end

    puts "Create Relationship: Roles, Delegates..."
    10.times do |i|
      Role.create(
        account: Account.find_by(email: "opentie#{i}@example.com"),
        division: Division.find_by(name: "division#{i}"),
        permission: "super"
      )

      Delegate.create(
        account: Account.find_by(email: "opentie#{i}@example.com"),
        group: Group.find_by(kibokan_id: i),
        permission: "super"
      )
    end

    10.times do |i|
      i = i + 10
      Role.create(
        account: Account.find_by(email: "opentie#{i}@example.com"),
        division: Division.find_by(name: "division#{i}"),
      )

      Delegate.create(
        account: Account.find_by(email: "opentie#{i}@example.com"),
        group: Group.find_by(kibokan_id: i),
      )
    end
  end
  puts "### Completed db/seeds.rb ###"
end
