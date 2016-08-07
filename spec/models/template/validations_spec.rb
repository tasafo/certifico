require 'rails_helper'

describe Template, 'validations' do
  context 'when valid data' do
    let!(:user) { create(:user, :paul) }
    let!(:template) { create(:template, :fisl, user: user) }

    it 'accepts valid attributes' do
      expect(template).to be_valid
    end
  end

  it 'requires name' do
    template = Template.create(name: nil)

    expect(template.errors[:name].size).to eq(1)
  end

  it 'requires font_color' do
    template = Template.create(font_color: nil)

    expect(template.errors[:font_color].size).to eq(1)
  end
end
