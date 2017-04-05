# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  let!(:assembled) { create :state, name: 'assembled', from_state: designed }
  let!(:painted) { create :state, name: 'painted', from_state: assembled }
  let!(:tested) { create :state, name: 'tested', from_state: painted }
  let!(:designed) { create :state, name: 'designed' }
  let(:vehicle) { create :vehicle }

  subject { vehicle }

  it { expect(subject).to be_valid }

  it 'should have initial state' do
    expect(subject.state).to eq(designed)
  end

  context 'state transitions' do
    it 'allows from_state designed to assembled' do
      subject.next_state!
      expect(subject.state).to eq(assembled)
    end

    it 'all should be reachable' do
      expect(subject.state).to eq(designed)
      subject.next_state!
      expect(subject.state).to eq(assembled)
      subject.next_state!
      expect(subject.state).to eq(painted)
      subject.next_state!
      expect(subject.state).to eq(tested)
      subject.next_state!
      expect(subject.state).to eq(tested)
    end

    it 'can be checked if there is a next state available' do
      expect(subject.next_state?).to be(true)
      subject.update_attribute(:state_id, tested.id)
      expect(subject.next_state?).to be(false)
    end

    it 'stops when last available state reached' do
      subject.update_attribute(:state_id, tested.id)
      expect(subject.state).to eq(tested)
      subject.next_state!
      expect(subject.state).to eq(tested)
      expect(subject.errors).to include(:state)
      expect(subject.errors.messages[:state]).to eq(['No more state transition available'])
    end

    it 'skiping state changes are not allowed' do
      subject.state = painted
      expect(subject.save).to be(false)
      expect(subject.errors).to include(:state)
    end

    context 'new states' do
      let!(:released) { create :state, name: 'released', from_state: tested }

      it 'should be reachable' do
        subject.update_attribute(:state_id, tested.id)
        expect(subject.state).to eq(tested)
        subject.next_state!
        expect(subject.state).to eq(released)
      end
    end
  end
end
