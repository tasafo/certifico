require 'rails_helper'

describe 'Remove template', js: true do
  let!(:user)          { create(:user, :paul) }
  let!(:template)      { create(:template, :fisl, user: user) }

  context 'without delete restriction' do
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

  context 'with delete restriction' do
    let!(:category)    { create(:category, :event) }
    let!(:certificate) { create(:certificate, :future, user: user, category: category, template: template) }

    before do
      login_as user

      click_link 'Modelos'

      click_with_alert "Remover"
    end

    it 'redirects to the templates page' do
      expect(current_path).to eql(templates_path)
    end

    it 'displays error message' do
      expect(page).to have_content('Não é possível remover o modelo devido o mesmo possuir certificados.')
    end
  end
end
