# frozen_string_literal: true
Given 'I have all the test data for state testing' do
  admin = FactoryGirl.create(:admin,
                             first_name: 'Admin',
                             last_name: 'Testing',
                             email: 'admin@test.com')
  admin.password = 123_456
  admin.password_confirmation = 123_456
  admin.save!
  user = FactoryGirl.create(:user,
                            first_name: 'User',
                            last_name: 'Testing',
                            email: 'user@test.com')
  user.password = 123_456
  user.password_confirmation = 123_456
  user.save!

  designed = FactoryGirl.create(:state, name: 'designed')
  assembled = FactoryGirl.create(:state, name: 'assembled', from_state: designed)
  painted = FactoryGirl.create(:state, name: 'painted', from_state: assembled)
  tested = FactoryGirl.create(:state, name: 'tested', from_state: painted)
  tested
end
