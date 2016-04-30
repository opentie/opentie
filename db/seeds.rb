# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.production?

  puts "### Starting db/seeds.rb env=production ###"

  Category.create('accounts', {
    _version: 0,
    name: 'accounts',
    metadata: {},
    forms: []
  })

  puts "### Conplete db/seeds.rb env=production ###"

else

  puts "### Starting db/seeds.rb ###"
  ActiveRecord::Base.transaction do
    puts "Create Accounts, Divisions, Groups..."
    20.times do |i|
      Account.create(
        email: "opentie#{i}@example.com",
        kibokan_id: "0",
        password: "password",
        password_confirmation: "password"
      )

      Division.create(
        name: "division#{i}"
      )

      Group.create(
        kibokan_id: "#{i}",
        category_name: "test"
      )
    end
  end

  ActiveRecord::Base.transaction do
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
        group: Group.find_by(kibokan_id: "#{i}"),
      )
    end
  end

  puts "Create topic..."
  ActiveRecord::Base.transaction do
    CreateTopicService.new(Division.first, Account.first).execute({
      title: "title",
      description: "des",
      group_ids: Group.select(:kibokan_id).all,
      is_draft: false,
      tag_list: ["tag", "tagtagtag"]
    })
  end

  puts "Create post..."
  ActiveRecord::Base.transaction do
    GroupTopic.all.each do |g|
      10.times do
        g.posts.create(
          body: "body",
          author: Account.first,
          division: Division.first,
          is_draft: false
        )
      end
    end
  end

  puts "### Completed db/seeds.rb ###"
end
