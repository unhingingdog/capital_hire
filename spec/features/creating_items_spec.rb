require 'spec_helper'
require 'rails_helper'

feature 'Creating Items' do
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
    visit "/"
    
  end
end
