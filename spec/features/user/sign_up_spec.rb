require 'rails_helper'

describe 'Sign up', js: true do
  context 'with valid data' do
    before do
      visit root_path

      click_link 'Inscrever-se'

      fill_in 'E-mail', with: 'paul@example.org'
      fill_in 'Nome completo', with: 'Paulo Moura'
      fill_in 'Nome de usuário', with: 'paulo'
      fill_in 'Senha', with: 'testdrive'
      fill_in 'Confirmação da senha', with: 'testdrive'

      click_button 'Inscrever-se'
    end

    it 'redirects to the the signup page' do
      expect(current_path).to eql(root_path)
    end

    it 'displays success message' do
      expect(page).to have_content('Você realizou seu registro com sucesso.')
    end
  end

  context 'with invalid data' do
    before do
      visit root_path

      click_link 'Inscrever-se'

      click_button 'Inscrever-se'
    end

    it 'displays error messages' do
      expect(page).to have_content('não pode ficar em branco')
    end
  end
end
