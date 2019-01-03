require 'rails_helper'

describe 'Remove certificate', js: true do
  let!(:user)        { create(:user, :paul) }
  let!(:template)    { create(:template, :fisl, user: user) }
  let!(:category)    { create(:category, :event) }
  let!(:certificate) { create(:certificate, :future, user: user, category: category, template: template) }

  context 'without delete restriction' do
    before do
      login_as user

      click_link 'Certificados'

      click_with_alert "Remover"
    end

    it 'redirects to the certificates page' do
      expect(current_path).to eql(certificates_path)
    end

    it 'displays success message' do
      expect(page).to have_content('Certificado foi removido com sucesso.')
    end
  end

  context 'with delete restriction' do
    let!(:profile)    { create(:profile, :participant) }
    let!(:subscriber) { create(:subscriber, user: user, profile: profile, certificate: certificate) }

    before do
      login_as user

      click_link 'Certificados'

      click_with_alert "Remover"
    end

    it 'redirects to the certificate page' do
      expect(current_path).to eql(certificate_path(certificate))
    end

    it 'displays error message' do
      expect(page).to have_content('Não é possível remover o certificado devido o mesmo possuir inscritos.')
    end
  end
end
