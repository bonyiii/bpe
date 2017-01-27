# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_role = Role.find_or_create_by!(name: 'admin')

admin = User.create_with(
  first_name: 'Main',
  last_name: 'Admin',
  password: 'password'
).find_or_create_by!(email: 'admin@test.com')

admin.roles = [admin_role]

User.create_with(
  first_name: 'First',
  last_name: 'User',
  password: 'password'
).find_or_create_by!(email: 'user@test.com')


designed_state = State.find_or_create_by!(name: 'designed')

assembled_state = State.create_with(
  from_state: designed_state
).find_or_create_by!(name: 'assembled')

painted_state = State.create_with(
  from_state: assembled_state
).find_or_create_by!(name: 'painted')

tested_state = State.create_with(
  from_state: painted_state
).find_or_create_by!(name: 'tested')
