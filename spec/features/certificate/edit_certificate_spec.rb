require 'rails_helper'

describe 'Edit certificate', js: true do
  let!(:user)         { create(:user, :paul) }
  let!(:template)     { create(:template, :fisl, user: user) }
  let!(:category)     { create(:category, :event) }
  let!(:certificate)  { create(:certificate, :future, user: user, category: category, template: template) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Certificados'
      click_link 'Editar'

      fill_in 'Título', with: 'Fórum Internacional de Software Livre 10.0'
      fill_in 'Data de início', with: '10/10/2010'
      fill_in 'Data de término', with: '13/10/2010'
      fill_in 'Carga horária', with: '32'
      fill_in 'Local', with: 'Centro de Convenções da PUC-RS, Porto Alegre-RS'
      fill_in 'Site', with: 'http://fisl.org/10'

      attach_file('Imagem', "#{Rails.root}/spec/support/assets/images/vaam_template.jpg")

      click_button 'Atualizar Certificado'
    end

    it 'redirects to the certificate page' do
      expect(current_path).to eql(certificate_path('forum-internacional-de-software-livre-10-ponto-0'))
    end

    it 'displays success message' do
      expect(page).to have_content('Certificado foi atualizado com sucesso.')
    end
  end

  context 'with invalid data' do
    before do
      login_as user

      click_link 'Certificados'
      click_link 'Editar'

      fill_in 'Título', with: ''

      click_button 'Atualizar Certificado'
    end

    it 'renders form page' do
      expect(current_path).to eql(certificate_path(certificate))
    end

    it 'displays error messages' do
      expect(page).to have_content('não pode ficar em branco')
    end
  end
end
