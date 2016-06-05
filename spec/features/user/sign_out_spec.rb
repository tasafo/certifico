require 'rails_helper'

describe 'Sign out' do
  context 'when logged in' do
    let!(:user) { create(:user, :paul) }

    before do
      login_as user

      visit root_path

      click_link 'Sair'
    end

    it 'redirects to home page' do
      expect(current_path).to eql(root_path)
    end

    it 'doesn\'t render name' do
      expect(page).not_to have_content('Login efetuado com sucesso.')
    end
  end
end
