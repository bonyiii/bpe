# frozen_string_literal: true

require 'rails_helper'
require 'pundit/rspec'

RSpec.describe ApplicationPolicy do
  let(:user) { create :user }
  let(:state) { create :state }

  subject { described_class }

  permissions :show? do
    it { expect(subject).to permit(user, state) }
  end

  permissions :index?, :new?, :create?, :edit?, :update?, :destroy? do
    it { expect(subject).not_to permit(user, :index) }
  end
end
