require 'rails_helper'

describe 'Send certificates', js: true do
  let!(:user)        { create(:user, :paul) }
  let!(:participant) { create(:profile, :participant) }
  let!(:organizer)   { create(:profile, :organizer) }
  let!(:template)    { create(:template, :fisl, user: user) }
  let!(:category)    { create(:category, :event) }
  let!(:certificate) { create(:certificate, :future, user: user, category: category, template: template) }
  let!(:subscriber)  { create(:subscriber, user: user, certificate: certificate, profile: participant) }

  before do
    ActiveJob::Base.queue_adapter = :test

    login_as user

    visit certificate_subscribers_path(certificate)
  end

  shared_examples 'verifications' do
    it 'redirects to the subscribers page' do
      expect(current_path).to eql(certificate_subscribers_path(certificate))
    end

    it 'displays success message' do
      expect(page).to have_content('Certificado(s) enviado(s) com sucesso!')
    end
  end

  context 'for all subscribers with success' do
    before do
      click_with_alert 'Enviar Certificados'
    end

    include_examples 'verifications'
  end

  context 'for one subscriber with success' do
    before do
      click_with_alert 'Enviar Certificado'
    end

    include_examples 'verifications'
  end
end
