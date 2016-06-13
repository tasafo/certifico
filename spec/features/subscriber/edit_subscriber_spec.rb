require 'rails_helper'

describe 'Edit subscriber', js: true do
  let!(:user)         { create(:user, :paul) }
  let!(:profile)      { create(:profile, :participant) }
  let!(:category)     { create(:category, :event) }
  let!(:template)     { create(:template, :fisl, user: user) }
  let!(:certificate)  { create(:certificate, :future, user: user, category: category, template: template) }
  let!(:subscriber)   { create(:subscriber, user: user, certificate: certificate, profile: profile) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Certificados'
      click_link 'Exibir'
      visit edit_certificate_subscriber_path(certificate, subscriber)

      fill_in 'Nome', with: 'Carlos Antônio'

      click_button 'Atualizar Inscrição'
    end

    it 'redirects to the certificate page' do
      expect(current_path).to eql(certificate_path(certificate))
    end

    it 'displays success message' do
      expect(page).to have_content('Inscrição foi atualizado com sucesso.')
    end
  end

  context 'with invalid data' do
    before do
      login_as user

      click_link 'Certificados'
      click_link 'Exibir'
      visit edit_certificate_subscriber_path(certificate, subscriber)

      fill_in 'E-mail', with: ''

      click_button 'Atualizar Inscrição'
    end

    it 'redirects to the certificate page' do
      expect(current_path).to eql(certificate_path(certificate))
    end

    it 'displays error message' do
      expect(page).to have_content('Inscrição foi atualizado com sucesso.')
    end
  end
end
