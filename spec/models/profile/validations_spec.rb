require 'rails_helper'

describe Profile, 'validations' do
  context 'when valid data' do
    let!(:profile) { create(:profile, :participant) }

    it 'accepts valid attributes' do
      expect(profile).to be_valid
    end
  end

  it 'requires name' do
    profile = Category.create(name: nil)

    expect(profile.errors[:name].size).to eq(1)
  end
end
