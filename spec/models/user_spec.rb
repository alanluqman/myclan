require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'alan', photo: 'http://picture', bio: 'I am developer') }
  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'user name should be alan' do
    expect(subject.name).to eq('alan')
  end

  it 'user photo should equal to http://picture' do
    expect(subject.photo).to eq('http://picture')
  end

  it 'user bio sould equal to I am developer' do
    expect(subject.bio).to eq('I am developer')
  end

  it 'user post_counter should be 0 at first' do
    expect(subject.post_counter).to eq(0)
  end

  it 'blank name raises error' do
    subject.name = ''
    expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed)
  end

  it 'post_counter thats not an integer raises error' do
    subject.post_counter = 'a'
    expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
