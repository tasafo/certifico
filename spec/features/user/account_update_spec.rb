require 'rails_helper'

describe 'Account update', js: true do
  let!(:user)         { create(:user, :paul) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Atualizar conta'

      fill_in 'Nome de usuário', with: 'carlos'
      fill_in 'Senha atual', with: user.password

      click_button 'Atualizar conta'
    end

    it 'redirects to the root page' do
      expect(current_path).to eql(root_path)
    end

    it 'displays success message' do
      expect(page).to have_content('Sua conta foi atualizada com sucesso.')
    end
  end
end
