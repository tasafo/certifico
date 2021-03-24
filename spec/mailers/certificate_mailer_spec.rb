require 'rails_helper'

describe CertificateMailer, type: :mailer do
  let!(:user)         { create(:user, :paul) }
  let!(:participant)  { create(:profile, :participant) }
  let!(:organizer)    { create(:profile, :organizer) }
  let!(:category)     { create(:category, :event) }
  let!(:template)     { create(:template, :fisl, user: user) }
  let!(:certificate)  { create(:certificate, :future, user: user, category: category, template: template) }
  let!(:subscriber)   { create(:subscriber, user: user, certificate: certificate, profile: participant) }

  describe 'notify' do
    let(:mail) do
      CertificateMailer.with(subscriber_id: subscriber.id.to_s).with_attachment
    end

    it 'renders the headers' do
      expect(mail.subject).to have_content('Certificado')
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Paulo Moura')
    end
  end
end
