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
      fill_in 'Horas', with: '32'
      fill_in 'Local', with: 'Centro de Convenções da PUC-RS, Porto Alegre-RS'
      fill_in 'Site', with: 'http://fisl.org/10'

      attach_file('Imagem', ImageFile.dummy('certificates', 'vaam.jpg'))

      find('.btn-submit').trigger('click')
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

      find('.btn-submit').trigger('click')
    end

    it 'renders form page' do
      expect(current_path).to eql(certificate_path(certificate))
    end

    it 'displays error messages' do
      expect(page).to have_content('não pode ficar em branco')
    end
  end

  context 'without authorization' do
    before do
      login_as user

      visit edit_certificate_path('1010101010101')
    end

    it 'redirects to the certificates page' do
      expect(current_path).to eql(certificates_path)
    end

    it 'displays error message' do
      expect(page).to have_content('Certificado não foi encontrado')
    end
  end
end
