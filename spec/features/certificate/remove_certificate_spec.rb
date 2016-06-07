require 'rails_helper'

describe 'Remove certificate', js: true do
  let!(:user)         { create(:user, :paul) }
  let!(:template)     { create(:template, :fisl, user: user) }
  let!(:category)     { create(:category, :event) }
  let!(:certificate)  { create(:certificate, :future, user: user, category: category, template: template) }

  context 'with valid data' do
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
end
