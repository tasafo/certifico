require 'rails_helper'

describe 'Create subscriber', js: true do
  let!(:user)         { create(:user, :paul) }
  let!(:profile)      { create(:profile, :participant) }
  let!(:category)     { create(:category, :event) }
  let!(:template)     { create(:template, :fisl, user: user) }
  let!(:certificate)  { create(:certificate, :future, user: user, category: category, template: template) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Certificados'
      click_link 'Exibir'
      click_link 'Novo Inscrito'

      fill_in 'E-mail', with: 'carlos@mail.com'
      fill_in 'Nome completo', with: 'Carlos Alexandre'
      fill_in 'Nome de usuário', with: 'carlos'
      select 'participante', from: 'subscriber_profile_id'

      click_button 'Criar Inscrito'
    end

    it 'redirects to the certificate page' do
      expect(current_path).to eql(certificate_path(certificate))
    end

    it 'displays success message' do
      expect(page).to have_content('Inscrito foi criado com sucesso.')
    end
  end

  context 'with invalid data' do
    before do
      login_as user

      click_link 'Certificados'
      click_link 'Exibir'
      click_link 'Novo Inscrito'

      click_button 'Criar Inscrito'
    end

    it 'renders form page' do
      expect(current_path).to eql(certificate_subscribers_path(certificate))
    end

    it 'displays error messages' do
      expect(page).to have_content('não pode ficar em branco')
    end
  end
end
