# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "### Starting db/seeds.rb ###"

Category.create('accounts', {
  _version: 0,
  name: 'accounts',
  metadata: {},
  forms: []
})

json_raw = File.read("#{Rails.root}/config/initial_category.json")
category_hash = JSON.parse(form_raw)

Category.create('groups', category_hash)

unless Rails.env.production?

  Category.create('groups', {
    _version: 0,
    name: 'normal',
    metadata: {},
    forms: []
  })

  kibokan_params = {
    _version: 0,
    metadata: {},
    document: {
      form1: {
        field1: 'hey',
        field2: 'option1',
        field3: 'foobar'
      }
    }
  }

  ActiveRecord::Base.transaction do
    puts "Create Accounts, Divisions, Groups..."
    20.times do |i|
      Account.create_with_kibokan(
        email: "opentie#{i}@example.com",
        password: "password",
        password_confirmation: "password",
        kibokan: kibokan_params
      )

      Division.create(
        name: "division#{i}"
      )

      Group.create_with_kibokan(
        kibokan_id: "#{i}",
        category_name: "normal",
        kibokan: kibokan_params
      )
    end

    if Rails.env.test?
      Account.all.each.with_index do |a, i|
        a.update(kibokan_id: "account#{i}")
      end
      Group.all.each.with_index do |g, i|
        g.update(kibokan_id: "group#{i}")
      end
    end
  end

  ActiveRecord::Base.transaction do
    puts "Create Relationship: Roles, Delegates..."
    Group.take(10).each.with_index do |g, i|
      Role.create(
        account: Account.find_by(email: "opentie#{i}@example.com"),
        division: Division.find_by(name: "division#{i}"),
        permission: "super"
      )

      Delegate.create(
        account: Account.find_by(email: "opentie#{i}@example.com"),
        group: g,
        permission: "super"
      )
    end

    Group.take(10).each.with_index do |g, i|
      i = i + 10
      Role.create(
        account: Account.find_by(email: "opentie#{i}@example.com"),
        division: Division.find_by(name: "division#{i}"),
      )

      Delegate.create(
        account: Account.find_by(email: "opentie#{i}@example.com"),
        group: g,
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
