module SpecHelpers
  def login_as(user)
    visit root_path

    click_link 'Entrar'

    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password

    click_button 'Entrar'
  end

  def webkit?
    [:webkit, :webkit_debug].include? Capybara.current_driver
  end

  def click_with_alert(target)
    if webkit?
      page.click_link target
      page.evaluate_script('window.confirm = function() { return true; }')
    else
      page.accept_alert do
        page.click_link target
      end
    end
  end
end
