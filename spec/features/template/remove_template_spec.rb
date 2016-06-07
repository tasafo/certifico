require 'rails_helper'

describe 'Remove template', js: true do
  let!(:user)     { create(:user, :paul) }
  let!(:template) { create(:template, :fisl, user: user) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Modelos'

      click_with_alert "Remover"
    end

    it 'redirects to the templates page' do
      expect(current_path).to eql(templates_path)
    end

    it 'displays success message' do
      expect(page).to have_content('Modelo foi removido com sucesso.')
    end
  end
end
