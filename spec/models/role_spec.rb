# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) { create :role }

  subject { role }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
end
