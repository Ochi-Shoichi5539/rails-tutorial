# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "factory_bot_rails"

5.times { FactoryBot.create(:user) }
FactoryBot.create(:user, account: 'a_endo@ga-tech.co.jp', password: 'a_endo@ga-tech.co.jp', password_confirmation: 'a_endo@ga-tech.co.jp')