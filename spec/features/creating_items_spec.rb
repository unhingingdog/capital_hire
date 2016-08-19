require 'spec_helper'
require 'rails_helper'

feature 'Creating Items' do
  before do
    visit '/'
    user = FactoryGirl.create(:user)
    mixers = FactoryGirl.create(:category)
    christchurch = FactoryGirl.create(:location)
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
  scenario "can create eqipment" do

    visit '/'
    click_link 'List Equipment'

    fill_in 'Title', with: 'Water blaster'
    fill_in 'Description', with: 'Some bullshit about a water blaster'
    expect(page).to have_content("Category")
    expect(page).to have_select("item[category_id]")
    select('mixers', from: 'item[category_id]')
    fill_in 'Rate', with: 10
    expect(page).to have_select("item[location_id]")
    select('Christchurch', from: 'item[location_id]')
    page.attach_file('item[image]', Rails.root + 'spec/Fixtures/mixer.jpg')
    click_button 'List Item'

    expect(page).to have_content("$10 per day")
    expect(page).to have_content("Water blaster")
  end

  scenario "can view item" do
    item = FactoryGirl.create(:item)
    visit "/"
    click_link 'Hire Equipment'
    click_link '10 fence'
    expect(page).to have_content("chainlink fences")
    expect(page).to have_content("$70 per day")
  end
end
