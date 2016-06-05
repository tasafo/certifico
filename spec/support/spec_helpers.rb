module SpecHelpers
  def login_as(user)
    visit root_path

    click_link 'Entrar'

    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password

    click_button 'Login'
  end
end
