require 'roo'

class SpreadSheet
  def self.import(certificate_id, subscriber)
    profile_id = subscriber[:profile_id]
    file = subscriber[:file]

    if subscriber[:profile_id].empty?
      raise "#{I18n.t('mongoid.attributes.subscriber.profile_id')} #{I18n.t('notice.import.was_not_selected')}"
    elsif subscriber[:file].nil?
      raise "#{I18n.t('mongoid.attributes.subscriber.file')} #{I18n.t('notice.import.was_not_selected')}"
    end

    begin
      spreadsheet = open(file)
    rescue Exception => e
      raise e.message
    end

    Subscriber.import(certificate_id, profile_id, spreadsheet)
  end

  def self.open(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".ods" then Roo::OpenOffice.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "#{I18n.t('notice.unsupported_file')}: #{file.original_filename}"
    end
  end
end
