Rails.application.config.i18n.default_locale = 'pt-BR'

Rails.application.config.i18n.load_path += Dir['config/locales/**/*.yml']

Date::DATE_FORMATS[:default] = '%d/%m/%Y'
