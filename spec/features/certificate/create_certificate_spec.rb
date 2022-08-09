require 'rails_helper'

describe 'Create certificate', js: true do
  let!(:user)     { create(:user, :paul) }
  let!(:template) { create(:template, :fisl, user: user) }
  let!(:category) { create(:category, :event) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Certificados'
      click_link 'Novo Certificado'

      select 'FISL', from: 'certificate_template_id'
      select 'Evento', from: 'certificate_category_id'
      fill_in 'Título', with: 'Fórum Internacional de Software Livre 10.0'
      fill_in 'Início', with: ''
      fill_in 'Início', with: '10/10/2010'
      fill_in 'Término', with: ''
      fill_in 'Término', with: '13/10/2010'
      fill_in 'Horas', with: '32'
      fill_in 'Local', with: 'Centro de Convenções da PUC-RS, Porto Alegre-RS'
      fill_in 'Site', with: 'http://fisl.org/10'

      attach_file('Imagem', ImageFile.dummy('certificates', 'vaam.jpg'))

      find('.btn-submit').trigger('click')
    end

    it 'redirects to the certificate page' do
      expect(current_path).to match(%r{/certificates/\w+})
    end

    it 'displays success message' do
      expect(page).to have_content('Certificado foi criado com sucesso.')
    end
  end

  context 'with invalid data' do
    before do
      login_as user

      click_link 'Certificados'
      click_link 'Novo Certificado'

      find('.btn-submit').trigger('click')
    end

    it 'renders form page' do
      expect(current_path).to eql(certificates_path)
    end

    it 'displays error messages' do
      expect(page).to have_content('não pode ficar em branco')
    end
  end
end
