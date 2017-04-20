require 'rails_helper'

describe 'Buy credits', js: true do
  let!(:user)             { create(:user, :paul) }
  let!(:credit_parameter) { create(:credit_parameter) }
  let!(:credit)           { create(:credit, user: user) }

  context 'with valid data' do
    before do
      login_as user

      click_link 'Créditos 10'
      click_link 'Comprar Crédito'

      fill_in 'Quantidade', with: 10

      click_button 'Comprar Crédito'
    end

    it 'redirects to the credit page' do
      expect(current_path).to match(credits_path)
    end
  end

  context 'with invalid data' do
    before do
      login_as user

      click_link 'Créditos 10'
      click_link 'Comprar Crédito'

      fill_in 'Quantidade', with: -1

      click_button 'Comprar Crédito'
    end

    it 'renders form page' do
      expect(current_path).to eql(credits_path)
    end

    it 'displays error messages' do
      expect(page).to have_content('deve ser maior ou igual a 1')
    end
  end
end
