require 'spec_helper'
require 'rails_helper'

feature 'Creating Items' do
  before do
    visit '/'
    user = FactoryGirl.create(:user)
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
    select 'Ladders', from: 'Category'
    fill_in 'Rate', with: 10
    click_button 'List Item'
  end

  scenario "can view item" do
    item = FactoryGirl.create(:item)
    visit "/"
    click_link '10 fence'
    expect(page).to have_content("chainlink fences")
    expect(page).to have_content("$70 per day")
  end
end
