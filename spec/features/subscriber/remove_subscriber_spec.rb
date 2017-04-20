require 'rails_helper'

describe 'Remove subscriber', js: true do
  let!(:user)        { create(:user, :paul) }
  let!(:participant) { create(:profile, :participant) }
  let!(:organizer)   { create(:profile, :organizer) }
  let!(:template)    { create(:template, :fisl, user: user) }
  let!(:category)    { create(:category, :event) }
  let!(:certificate) { create(:certificate, :future, user: user, category: category, template: template) }

  context 'without delete restriction' do
    let!(:subscriber)  { create(:subscriber, user: user, certificate: certificate, profile: participant) }

    before do
      login_as user

      visit certificate_subscribers_path(certificate)

      click_with_alert "Remover"
    end

    it 'redirects to the subscribers page' do
      expect(current_path).to eql(certificate_subscribers_path(certificate))
    end

    it 'displays success message' do
      expect(page).to have_content('Inscrito foi removido com sucesso.')
    end
  end

  context 'with delete restriction' do
    let!(:subscriber) { create(:subscriber, user: user, certificate: certificate, profile: organizer) }
    let!(:download) { create(:download, subscriber: subscriber, user: user, certificate: certificate) }

    before do
      login_as user

      visit certificate_subscribers_path(certificate)

      click_with_alert "Remover"
    end

    it 'redirects to the subscribers page' do
      expect(current_path).to eql(certificate_subscribers_path(certificate))
    end

    it 'displays error message' do
      expect(page).to have_content('Não é possível remover o inscrito devido ele ter realizado download do certificado.')
    end
  end
end
