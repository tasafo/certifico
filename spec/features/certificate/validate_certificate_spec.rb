require 'rails_helper'

describe 'Show issues', js: true do
  let!(:user)         { create(:user, :paul) }
  let!(:profile)      { create(:profile, :participant) }
  let!(:category)     { create(:category, :event) }
  let!(:template)     { create(:template, :fisl, user: user) }
  let!(:certificate)  { create(:certificate, :future, user: user, category: category, template: template) }
  let!(:subscriber)   { create(:subscriber, user: user, certificate: certificate, profile: profile) }

  context 'show with valid data' do
    before do
      visit validate_path(subscriber)
    end

    it 'redirects to the issue page' do
      expect(current_path).to eql(validate_path(subscriber))
    end

    it 'displays success message' do
      expect(page).to have_content('Validação de certificado')
    end
  end

  context 'form with valid data' do
    before do
      visit new_validate_path
      fill_in 'Código', with: subscriber.id
      click_button 'Validar Certificado'
    end

    it 'redirects to the validate page' do
      expect(current_path).to eql(validate_path(subscriber))
    end

    it 'displays success message' do
      expect(page).to have_content('Validação de certificado')
    end
  end

  context 'show with invalid data' do
    before do
      visit validate_path('111111111111111111')
    end

    it 'redirects to the issue page' do
      expect(current_path).to eql(root_path)
    end

    it 'displays error message' do
      expect(page).to have_content('Certificado não foi encontrado(a).')
    end
  end

  context 'form with invalid data' do
    before do
      visit new_validate_path
      fill_in 'Código', with: '111111111111111111'
      click_button 'Validar Certificado'
    end

    it 'redirects to the new validate page' do
      expect(current_path).to eql(new_validate_path)
    end

    it 'displays error message' do
      expect(page).to have_content('Certificado não foi encontrado(a).')
    end
  end
end
