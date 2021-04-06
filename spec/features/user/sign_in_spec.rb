require 'rails_helper'

describe 'Sign in', js: true do
  context 'with valids credential' do
    let!(:user) { create(:user, :paul) }

    before do
      visit root_path

      click_link 'Entrar'

      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password

      click_button 'Entrar'
    end

    it 'redirects to home page' do
      expect(current_path).to eql(root_path)
    end

    it 'displays greeting message' do
      expect(page).to have_content('Login efetuado com sucesso.')
    end
  end

  context 'with invalid credentials' do
    before do
      visit root_path
      click_link 'Entrar'
      click_button 'Entrar'
    end

    it 'redirects to home page' do
      expect(current_path).to eql(new_user_session_path)
    end

    it 'displays error message' do
      expect(page).to have_content('E-mail ou senha inválidos.')
    end
  end
end
