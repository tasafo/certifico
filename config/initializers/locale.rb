Rails.application.config.i18n.default_locale = 'pt-BR'

Rails.application.config.i18n.load_path += Dir["config/locales/**/*.yml"]

Rails.application.config.time_zone = 'Brasilia'

#Date::DATE_FORMATS[:default] = I18n.locale == 'pt-BR' ? '%d/%m/%Y' : '%m/%d/%Y'
Date::DATE_FORMATS[:default] = '%d/%m/%Y'
