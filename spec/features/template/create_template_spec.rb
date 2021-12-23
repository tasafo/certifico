require 'rails_helper'

describe 'Create template', js: true do
  let!(:user) { create(:user, :paul) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Modelos'
      click_link 'Novo Modelo'

      fill_in 'Nome', with: 'Modelo de certificado'
      fill_in 'Cor da fonte', with: '#000000'
      attach_file('Imagem', ImageFile.dummy_template)

      click_button 'Criar Modelo'
    end

    it 'redirects to the template page' do
      expect(current_path).to match(%r{/templates/\w+})
    end

    it 'displays success message' do
      expect(page).to have_content('Modelo foi criado com sucesso.')
    end
  end

  context 'with invalid data' do
    before do
      login_as user

      click_link 'Modelos'
      click_link 'Novo Modelo'

      attach_file('Imagem', Rails.root.join('public', 'robots.txt'))

      click_button 'Criar Modelo'
    end

    it 'renders form page' do
      expect(current_path).to eql(templates_path)
    end

    it 'displays error messages' do
      expect(page).to have_content('não pode ficar em branco')
    end
  end
end
