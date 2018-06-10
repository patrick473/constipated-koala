# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# encoding: UTF-8

require 'faker'

Faker::Config.locale = :nl
puts '-- Populate the database with default configuration'

# Default values required for educations
puts '-- Creating studies'
Study.transaction do
  Study.create(
    id:      1,
    code:    'INCA',
    masters: false
  )
  Study.create(
    id:      2,
    code:    'INKU',
    masters: false
  )
  Study.create(
    id:      3,
    code:    'GT',
    masters: false
  )
  Study.create(
    id:      4,
    code:    'COSC',
    masters: true
  )
  Study.create(
    id:      5,
    code:    'MBIM',
    masters: true
  )
  Study.create(
    id:      6,
    code:    'AINM',
    masters: true
  )
  Study.create(
    id:      7,
    code:    'GMTE',
    masters: true
  )
end

# Create one board which by default is not selectable in the app
puts '-- Creating board group'
Group.create(
  name:       'Bestuur',
  category:   1,
  created_at: Faker::Date.between(3.years.ago, 2.years.ago)
)

puts '-- Creating membership activity'
Activity.create(
  name:          'Lidmaatschap',
  price:         7.5,
  start_date:    Faker::Date.between(30.days.ago, 7.days.ago),
  is_enrollable: false,
  is_masters:    false,
  is_viewable:   false,
  is_alcoholic:  false,
  is_freshmans:  false
)

# Seeds not working on CI
exit unless Rails.env.development? || Rails.env.staging?

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end

puts '-- done'
