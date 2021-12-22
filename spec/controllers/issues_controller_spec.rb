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

  context 'Generate pdf file for' do
    let(:pdf_string)  { subscriber.generate_certificate.save }
    let(:file_name)   { 'certifico_paulo-moura_o-que-sera-do-futuro-no-passado_participante.pdf' }
    let(:pdf_options) { { filename: file_name, type: 'application/pdf' } }
    let(:params)      { { id: subscriber.id } }

    before do
      expect(@controller).to receive(:send_data)
        .with(pdf_string, pdf_options)

      sign_in user
    end

    context 'user' do
      it 'streams the result as a pdf file' do
        patch :update, params: params.merge(format: 'html')
      end
    end

    context 'admin' do
      it 'streams the result as a pdf file' do
        delete :destroy, params: params.merge(format: 'html')
      end
    end
  end
end
