require 'rails_helper'

describe 'Edit subscriber', js: true do
  let!(:user)         { create(:user, :paul) }
  let!(:participant)  { create(:profile, :participant) }
  let!(:organizer)    { create(:profile, :organizer) }
  let!(:category)     { create(:category, :event) }
  let!(:template)     { create(:template, :fisl, user: user) }
  let!(:certificate)  { create(:certificate, :future, user: user, category: category, template: template) }
  let!(:subscriber)   { create(:subscriber, user: user, certificate: certificate, profile: participant) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Certificados'
      click_link 'Exibir'
      visit edit_certificate_subscriber_path(certificate, subscriber)

      select 'organizador', from: 'subscriber_profile_id'

      click_button 'Atualizar Inscrito'
    end

    it 'redirects to the subscribers page' do
      expect(current_path).to eql(certificate_subscribers_path(certificate))
    end

    it 'displays success message' do
      expect(page).to have_content('Inscrito foi atualizado com sucesso.')
    end
  end

  context 'with profile existing' do
    let!(:subscriber2)   { create(:subscriber, user: user, certificate: certificate, profile: organizer) }

    before do
      login_as user

      click_link 'Certificados'
      click_link 'Exibir'
      visit edit_certificate_subscriber_path(certificate, subscriber2)

      select 'participant', from: 'subscriber_profile_id'

      click_button 'Atualizar Inscrito'
    end

    it 'redirects to the subscriber page' do
      expect(current_path).to eql(edit_certificate_subscriber_path(certificate, subscriber2))
    end

    it 'displays success message' do
      expect(page).to have_content('Perfil já está em uso')
    end
  end

  context 'without profile' do
    let!(:subscriber2)   { create(:subscriber, user: user, certificate: certificate, profile: organizer) }

    before do
      login_as user

      click_link 'Certificados'
      click_link 'Exibir'
      visit edit_certificate_subscriber_path(certificate, subscriber2)

      select '', from: 'subscriber_profile_id'

      click_button 'Atualizar Inscrito'
    end

    it 'redirects to the subscriber page' do
      expect(current_path).to eql(certificate_subscriber_path(certificate, subscriber2))
    end
  end
end
