module SpecHelpers
  def login_as(user)
    visit root_path

    click_link 'Entrar'

    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password

    click_button 'Entrar'
  end

  def click_with_alert(target)
    page.accept_alert do
      page.click_on target
    end
  end

  def spreadsheets_file(file)
    Rails.root.join('spec', 'support', 'assets', 'spreadsheets', file)
  end
end
