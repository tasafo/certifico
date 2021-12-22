require 'roo'

class SpreadSheet
  def self.setup(params, certificate)
    subscriber = params[:subscriber]

    options = {
      certificate: certificate,
      profile_id: subscriber[:profile_id],
      file: subscriber[:file]
    }

    import(**options)
  end

  def self.import(certificate:, profile_id:, file:)
    raise error_message('profile_id') if profile_id.blank?
    raise error_message('file') if file.nil?

    begin
      spreadsheet = open_sheet(file)
    rescue StandardError => e
      raise e.message
    end

    Subscriber.import(certificate, profile_id, spreadsheet)
  end

  def self.error_message(field)
    "#{I18n.t("mongoid.attributes.subscriber.#{field}")} \
    #{I18n.t('notice.import.was_not_selected')}"
  end

  def self.open_sheet(file)
    file_path = file.path
    filename = file.original_filename

    case File.extname(filename)
    when '.csv' then CSV.read(file_path)
    when '.ods' then Roo::OpenOffice.new(file_path)
    when '.xls' then Roo::Excel.new(file_path)
    when '.xlsx' then Roo::Excelx.new(file_path)
    else raise "#{I18n.t('notice.unsupported_file')}: #{filename}"
    end
  end
end
