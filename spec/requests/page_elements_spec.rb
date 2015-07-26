require 'spec_helper'

describe 'Home Page' do

  subject { page }

  before do
    Setting.create(
      key: 'company_name',
      pretty_name: 'Copmany Name',
      value: 'ABC Company'
    )
    visit root_path
  end

  describe 'layout' do
    it 'should have the correct title' do
      expect(page).to have_title('Home | ABC Company')
    end

    describe 'as admin' do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it 'should have the admin sidebar' do
        expect(page).to have_css('div.sidebar')
      end
    end

    describe 'as normal user' do
      it 'should not have the admin sidebar' do
        expect(page).to_not have_css('div.sidebar')
      end
    end
  end
end
