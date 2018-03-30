require 'rails_helper'

describe Subscriber, 'validations' do
  let!(:user)         { create(:user, :paul) }
  let!(:profile)      { create(:profile, :participant) }
  let!(:category)     { create(:category, :event) }
  let!(:template)     { create(:template, :fisl, user: user) }
  let!(:certificate)  { create(:certificate, :future, user: user, category: category, template: template) }
  let!(:subscriber)   { create(:subscriber, user: user, profile: profile, certificate: certificate) }
  let!(:params)       { { profile: profile.name, search: 'paulo' } }

  context 'when valid data' do
    it 'accepts valid attributes' do
      expect(subscriber).to be_valid
    end
  end

  it 'requires user' do
    subscriber = Subscriber.create(user: nil)

    expect(subscriber.errors[:user].size).to eq(1)
  end

  it 'requires profile' do
    subscriber = Subscriber.create(profile: nil)

    expect(subscriber.errors[:profile].size).to eq(1)
  end

  it 'requires certificate' do
    subscriber = Subscriber.create(certificate: nil)

    expect(subscriber.errors[:certificate].size).to eq(1)
  end

  context 'when searching by user name or email' do
    it 'must find subscribers' do
      expect(Subscriber.search(params, certificate).count).to eq(1)
    end
  end
end
