require 'rails_helper'

describe IssuesController, type: :controller do
  let!(:user)        { create(:user, :paul) }
  let!(:profile)     { create(:profile, :participant) }
  let!(:category)    { create(:category, :event) }
  let!(:template)    { create(:template, :fisl, user: user) }
  let!(:certificate) { create(:certificate, :future, user: user, category: category, template: template) }
  let!(:subscriber)  { create(:subscriber, user: user, certificate: certificate, profile: profile) }

  context 'GET: subscribers' do
    it 'should to be success' do
      sign_in user

      params = { id: subscriber.id }

      get :index, params: params.merge(format: 'html')

      expect(response.status).to eql(200)
    end
  end

  context 'Generate pdf file for user' do
    let(:pdf_string)  { GenerateCertificate.new(subscriber).save }
    let(:pdf_options) {
      {
        filename: "certifico_paulo-moura_o-que-sera-do-futuro-no-passado_participante.pdf",
        type: 'application/pdf'
      }
    }

    before do
      expect(@controller).to receive(:send_data)
        .with(pdf_string, pdf_options)
    end

    it "streams the result as a pdf file" do
      sign_in user

      params = { id: subscriber.id }

      patch :update, params: params.merge(format: 'html')
    end
  end

  context 'Generate pdf file for admin' do
    let(:pdf_string)  { GenerateCertificate.new(subscriber).save }
    let(:pdf_options) {
      {
        filename: "certifico_paulo-moura_o-que-sera-do-futuro-no-passado_participante.pdf",
        type: 'application/pdf'
      }
    }

    before do
      expect(@controller).to receive(:send_data)
        .with(pdf_string, pdf_options)
    end

    it "streams the result as a pdf file" do
      sign_in user

      params = { id: subscriber.id }

      delete :destroy, params: params.merge(format: 'html')
    end
  end

end
