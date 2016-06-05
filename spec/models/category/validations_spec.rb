require 'rails_helper'

describe Category, 'validations' do
  context 'when valid data' do
    let!(:category) { create(:category, :event) }

    it 'accepts valid attributes' do
      expect(category).to be_valid
    end
  end

  it 'requires name' do
    category = Category.create(name: nil)

    expect(category.errors[:name].size).to eq(1)
  end

  it 'requires preposition' do
    category = Category.create(preposition: nil)

    expect(category.errors[:preposition].size).to eq(1)
  end
end
