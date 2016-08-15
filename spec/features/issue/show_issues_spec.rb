require 'rails_helper'

describe 'Show issues', js: true do
  let!(:user)         { create(:user, :paul) }
  let!(:user2)        { create(:user, :billy) }
  let!(:user3)        { create(:user, :luis) }
  let!(:profile)      { create(:profile, :participant) }
  let!(:profile2)     { create(:profile, :speaker) }
  let!(:profile3)     { create(:profile, :organizer) }
  let!(:category)     { create(:category, :event) }
  let!(:template)     { create(:template, :fisl, user: user) }
  let!(:certificate1) { create(:certificate, :future, user: user, category: category, template: template) }
  let!(:certificate2) { create(:certificate, :future, user: user, category: category, template: template, final_date: '2016-06-07') }
  let!(:certificate3) { create(:certificate, :future, user: user, category: category, template: template, initial_date: '2015-11-30', final_date: '2015-12-01') }
  let!(:certificate4) { create(:certificate, :future, user: user, category: category, template: template, initial_date: '2015-12-30', final_date: '2016-01-01') }
  let!(:subscriber1)  { create(:subscriber, user: user2, certificate: certificate1, profile: profile) }
  let!(:subscriber2)  { create(:subscriber, user: user3, certificate: certificate2, profile: profile2, theme: 'Slackware Linux') }
  let!(:subscriber3)  { create(:subscriber, user: user3, certificate: certificate3, profile: profile) }
  let!(:subscriber4)  { create(:subscriber, user: user3, certificate: certificate4, profile: profile3) }

  context 'with same dates' do
    before do
      login_as user2

      click_link 'Emissões'
      visit issue_path(subscriber1)
    end

    it 'redirects to the issue page' do
      expect(current_path).to eql(issue_path(subscriber1))
    end
  end

  context 'with different dates' do
    before do
      login_as user3

      click_link 'Emissões'
      visit issue_path(subscriber2)
    end

    it 'redirects to the issue page' do
      expect(current_path).to eql(issue_path(subscriber2))
    end
  end

  context 'with different months' do
    before do
      login_as user3

      click_link 'Emissões'
      visit issue_path(subscriber3)
    end

    it 'redirects to the issue page' do
      expect(current_path).to eql(issue_path(subscriber3))
    end
  end

  context 'with different years' do
    before do
      login_as user3

      click_link 'Emissões'
      visit issue_path(subscriber4)
    end

    it 'redirects to the issue page' do
      expect(current_path).to eql(issue_path(subscriber4))
    end
  end

  context 'with different user' do
    before do
      login_as user3

      click_link 'Emissões'
      visit issue_path(subscriber1)
    end

    it 'redirects to the issues page' do
      expect(current_path).to eql(issues_path)
    end
  end
end
