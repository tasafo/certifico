require 'rails_helper'

describe 'Change Username', js: true do
  let!(:user) { create(:user, :paul) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Emissões'
      click_link 'Editar Nome completo'

      fill_in 'Nome completo', with: 'Alberto Roberto'

      click_button 'Atualizar Usuário'
    end

    it 'redirects to the issues page' do
      expect(current_path).to eql(issues_path)
    end

    it 'displays success message' do
      expect(page).to have_content('Usuário foi atualizado com sucesso.')
    end
  end

  context 'with invalid data' do
    before do
      login_as user

      click_link 'Emissões'
      click_link 'Editar Nome completo'

      fill_in 'Nome completo', with: ''

      click_button 'Atualizar Usuário'
    end

    it 'renders form page' do
      expect(current_path).to eql(username_path(user))
    end

    it 'displays error messages' do
      expect(page).to have_content('não pode ficar em branco')
    end
  end
end
