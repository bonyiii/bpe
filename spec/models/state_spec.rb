# frozen_string_literal: true

require 'rails_helper'

RSpec.describe State, type: :model do
  let(:assembled) { create :state, name: 'assembled', from_state: designed }
  let(:painted) { create :state, name: 'painted', from_state: assembled }
  let(:tested) { create :state, name: 'tested', from_state: painted }
  let(:designed) { create :state, name: 'designed' }

  it { should validate_presence_of(:name) }

  it 'should keep reference' do
    expect(tested.from_state).to eq(painted)
  end

  context 'scopes' do
    describe '#initial' do
      it 'should return the default state' do
        assembled
        expect(State.initial).to eq(designed)
      end
    end

    describe '#list' do
      it 'should return states in proper hierarchy' do
        assembled
        painted
        tested
        designed
        expect(State.list.map(&:id)).to eq([designed.id, assembled.id, painted.id, tested.id])
      end
    end
  end

  describe '#destroy' do
    it 'should not destroy if dependent state exists' do
      assembled
      expect(designed.destroy).to be(false)
    end
  end
end
