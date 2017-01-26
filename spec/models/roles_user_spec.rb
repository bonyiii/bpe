require 'rails_helper'

RSpec.describe RolesUser, type: :model do
  it { should validate_presence_of(:role) }
  it { should validate_presence_of(:user) }
end
