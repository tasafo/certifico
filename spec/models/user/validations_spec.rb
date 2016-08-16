require 'rails_helper'

describe User, 'validations' do
  let!(:user) { create(:user, :paul) }

  context 'when valid data' do
    it 'accepts valid attribuites' do
      expect(user).to be_valid
    end
  end

  it 'requires e-mail' do
    user = User.create(email: nil)

    expect(user.errors[:email].size).to eq(2)
  end

  it 'requires valid e-mail' do
    user = User.create(email: 'invalid')

    expect(user.errors[:email].size).to eq(1)
  end

  it 'accepts valid e-mail' do
    user = User.create(email: 'luiz@example.org')

    expect(user.errors[:email].size).to eq(0)
  end

  it 'requires password' do
    user = User.create(password: nil)

    expect(user.errors[:password].size).to eq(1)
  end

  it 'requires password confirmation' do
    user = User.create(
      password: 'testdrive',
      password_confirmation: 'invalid!'
    )

    expect(user.errors[:password_confirmation].size).to eq(1)
  end

  it 'set password hash when setting password' do
    user = User.create(password: 'testdrive')

    expect(user.encrypted_password).not_to be_blank
  end
end
