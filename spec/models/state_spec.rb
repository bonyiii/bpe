# frozen_string_literal: true
require 'rails_helper'

RSpec.describe State, type: :model do
  let(:assembled) { create :state, name: 'assembled', from: designed }
  let(:painted) { create :state, name: 'painted', from: assembled }
  let(:tested) { create :state, name: 'tested', from: painted }
  let(:designed) { create :state, name: 'designed' }

  it 'should keep reference' do
    expect(tested.from).to eq(painted)
  end

  context 'scopes' do
    context 'initial' do
      it 'should return the default state' do
        assembled
        expect(State.initial).to eq(designed)
      end
    end
  end
end
