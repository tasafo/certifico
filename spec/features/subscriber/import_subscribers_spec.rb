require 'rails_helper'

describe 'Import subscribers', js: true do
  let!(:paul)             { create(:user, :paul) }
  let!(:participant)      { create(:profile, :participant) }
  let!(:speaker)          { create(:profile, :speaker) }
  let!(:voluntary)        { create(:profile, :voluntary) }
  let!(:organizer)        { create(:profile, :organizer) }
  let!(:category)         { create(:category, :event) }
  let!(:template)         { create(:template, :fisl, user: paul) }
  let!(:certificate)      { create(:certificate, :future, user: paul, category: category, template: template) }
  let!(:credit_parameter) { create(:credit_parameter) }
  let!(:credit)           { create(:credit, user: paul) }

  context 'participants with valid data' do
    before do
      credit.update(paid_at: DateTime.now)

      login_as paul

      click_link 'Certificados'
      click_link 'Inscritos'
      click_link 'Importar Inscritos'

      select 'participante', from: 'subscriber_profile_id'
      attach_file('Arquivo', 'spec/support/assets/spreadsheets/participants.csv')

      click_button 'Importar Inscritos'
    end

    it 'redirects to the subscribers page' do
      expect(current_path).to eql(certificate_subscribers_path(certificate))
    end

    it 'displays success message' do
      expect(page).to have_content('Inscritos foram importados com sucesso.')
    end
  end

  context 'voluntaries with valid data' do
    before do
      login_as paul

      click_link 'Certificados'
      click_link 'Inscritos'
      click_link 'Importar Inscritos'

      select 'voluntário', from: 'subscriber_profile_id'
      attach_file('Arquivo', 'spec/support/assets/spreadsheets/voluntaries.xlsx')

      click_button 'Importar Inscritos'
    end

    it 'redirects to the subscribers page' do
      expect(current_path).to eql(certificate_subscribers_path(certificate))
    end

    it 'displays success message' do
      expect(page).to have_content('Inscritos foram importados com sucesso.')
    end
  end

  context 'organizers with valid data' do
    before do
      login_as paul

      click_link 'Certificados'
      click_link 'Inscritos'
      click_link 'Importar Inscritos'

      select 'organizador', from: 'subscriber_profile_id'
      attach_file('Arquivo', 'spec/support/assets/spreadsheets/organizers.ods')

      click_button 'Importar Inscritos'
    end

    it 'redirects to the subscribers page' do
      expect(current_path).to eql(certificate_subscribers_path(certificate))
    end

    it 'displays success message' do
      expect(page).to have_content('Inscritos foram importados com sucesso.')
    end
  end

  context 'speakers with valid data' do
    before do
      login_as paul

      click_link 'Certificados'
      click_link 'Inscritos'
      click_link 'Importar Inscritos'

      select 'palestrante', from: 'subscriber_profile_id'
      attach_file('Arquivo', 'spec/support/assets/spreadsheets/speakers.xls')

      click_button 'Importar Inscritos'
    end

    it 'redirects to the subscribers page' do
      expect(current_path).to eql(certificate_subscribers_path(certificate))
    end

    it 'displays success message' do
      expect(page).to have_content('Inscritos foram importados com sucesso.')
    end
  end

  context 'without profile' do
    before do
      login_as paul

      click_link 'Certificados'
      click_link 'Inscritos'
      click_link 'Importar Inscritos'

      click_button 'Importar Inscritos'
    end

    it 'redirects to the import subscriber page' do
      expect(current_path).to eql(new_certificate_import_subscriber_path(certificate))
    end

    it 'displays error message' do
      expect(page).to have_content('Perfil não foi selecionado')
    end
  end

  context 'without file' do
    before do
      login_as paul

      click_link 'Certificados'
      click_link 'Inscritos'
      click_link 'Importar Inscritos'

      select 'participante', from: 'subscriber_profile_id'

      click_button 'Importar Inscritos'
    end

    it 'redirects to the import subscriber page' do
      expect(current_path).to eql(new_certificate_import_subscriber_path(certificate))
    end

    it 'displays error message' do
      expect(page).to have_content('Arquivo não foi selecionado')
    end
  end

  context 'with unsupported file' do
    before do
      login_as paul

      click_link 'Certificados'
      click_link 'Inscritos'
      click_link 'Importar Inscritos'

      select 'participante', from: 'subscriber_profile_id'
      attach_file('Arquivo', 'spec/support/assets/spreadsheets/unsupported_file.txt')

      click_button 'Importar Inscritos'
    end

    it 'redirects to the import subscriber page' do
      expect(current_path).to eql(new_certificate_import_subscriber_path(certificate))
    end

    it 'displays error message' do
      expect(page).to have_content('Arquivo não suportado: unsupported_file.txt')
    end
  end

  context 'participants with invalid data' do
    before do
      login_as paul

      click_link 'Certificados'
      click_link 'Inscritos'
      click_link 'Importar Inscritos'

      select 'participante', from: 'subscriber_profile_id'
      attach_file('Arquivo', 'spec/support/assets/spreadsheets/invalid_participants.csv')

      click_button 'Importar Inscritos'
    end

    it 'redirects to the import subscriber page' do
      expect(current_path).to eql(new_certificate_import_subscriber_path(certificate))
    end

    it 'displays success message' do
      expect(page).to have_content('E-mail inválido')
    end
  end
end
