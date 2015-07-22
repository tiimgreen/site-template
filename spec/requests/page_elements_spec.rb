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

    describe 'as normal use' do
      it 'should not have the admin sidebar' do
        expect(page).to_not have_css('div.sidebar')
      end
    end
  end

  describe 'PageElementText' do

    describe 'as normal user' do

      it 'should have default content' do
        expect(page).to have_selector('p', text: 'Lorem ipsum dolor sit amet domo, consectetur adipisicing elit.')
      end

      it 'should not have admin link' do
        expect(page).to_not have_link('Edit')
      end
    end

    describe 'as admin user' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end

      it 'should have default content' do
        expect(page).to have_selector('p', text: 'Lorem ipsum dolor sit amet domo, consectetur adipisicing elit.')
      end

      it 'should have admin link' do
        expect(page).to have_link('Edit')
      end
    end
  end

  describe 'PageElementLink' do

    describe 'as normal user' do

      it 'should have default content' do
        expect(page).to have_link('Lorem ipsum dolor sit amet domo, consectetur adipisicing elit.', href: '/')
      end
    end

    describe 'as admin user' do

      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end

      it 'should have default content' do
        expect(page).to have_link('Lorem ipsum dolor sit amet domo, consectetur adipisicing elit.', href: '/')
      end

      it 'should have admin link' do
        expect(page).to have_link('Edit')
      end
    end
  end
end
