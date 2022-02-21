require 'rails_helper'

describe 'Sign out', js: true do
  context 'when logged in' do
    let!(:user) { create(:user, :paul) }

    before do
      login_as user
      visit root_path
      click_link 'Olá, paulo'
      click_link 'Sair'
    end

    it 'redirects to home page' do
      expect(current_path).to eql(root_path)
    end

    it 'displays success message' do
      expect(page).to have_content('Logout efetuado com sucesso.')
    end
  end
end
