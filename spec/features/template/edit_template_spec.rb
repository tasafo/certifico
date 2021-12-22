require 'rails_helper'

describe 'Edit template', js: true do
  let!(:user) { create(:user, :paul) }
  let!(:template) { create(:template, :fisl, user: user) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Modelos'
      click_link 'Editar'

      fill_in 'Nome', with: 'Nome do modelo alterado'

      click_button 'Atualizar Modelo'
    end

    it 'redirects to the template page' do
      expect(current_path).to eql(template_path('nome-do-modelo-alterado'))
    end

    it 'displays success message' do
      expect(page).to have_content('Modelo foi atualizado com sucesso.')
    end
  end

  context 'with invalid data' do
    before do
      login_as user

      click_link 'Modelos'
      click_link 'Editar'

      fill_in 'Nome', with: ''

      click_button 'Atualizar Modelo'
    end

    it 'renders form page' do
      expect(current_path).to eql(template_path(template))
    end

    it 'displays error messages' do
      expect(page).to have_content('não pode ficar em branco')
    end
  end

  context 'without authorization' do
    before do
      login_as user

      visit edit_template_path('1010101010101')
    end

    it 'redirects to the templates page' do
      expect(current_path).to eql(templates_path)
    end

    it 'displays error message' do
      expect(page).to have_content('Modelo não foi encontrado')
    end
  end
end
