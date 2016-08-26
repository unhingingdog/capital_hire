require 'spec_helper'
require 'rails_helper'

feature 'searching items' do
  before :each do
    @category1 = FactoryGirl.create(:category, name: "Trailers")
    @category2 = FactoryGirl.create(:category, name: "Scaffolding")
    @location1 = FactoryGirl.create(:location, name: "Christchurch")
    @location2 = FactoryGirl.create(:location, name: "Wellington")
    @item = FactoryGirl.create(:item, title: "heavy mixer",
                              location_id: @location1.id, category_id: @category1.id,
                              specs: "Sorry, I can't do that Dave")
    @item2 = FactoryGirl.create(:item, title: "Aluminum scaffolding",
                              location_id: @location1.id, category_id: @category2.id,
                              specs: "Sorry, I can't do that Dave")
    @item3 = FactoryGirl.create(:item, title: "light mixer",
                              location_id: @location2.id, category_id: @category1.id,
                              specs: "Sorry, I can't do that Dave")
    @item4 = FactoryGirl.create(:item, title: "Steel scaffolding",
                              location_id: @location2.id, category_id: @category2.id,
                              specs: "Sorry, I can't do that Dave")

      visit '/'
  end

  scenario 'searching with location and category' do
    fill_in 'query', with: @item.title
    fill_in 'location', with: @location1.name
    fill_in 'category', with: @category1.name
    click_button 'Search Equipment'
    expect(page).to have_content(@item.title)
    expect(page).to have_content("Sorry, I can't do that Dave")
    expect(page).to_not have_content(@item2.title)
    expect(page).to_not have_content(@item3.title)
  end

  scenario 'searching for all' do
    fill_in 'query', with: ""
    fill_in 'location', with: ""
    fill_in 'category', with: ""
    click_button 'Search Equipment'
    expect(page).to have_content(@item.title)
    expect(page).to have_content(@item2.title)
    expect(page).to have_content(@item3.title)
  end

  scenario 'searching for keyword in all categories and locations' do
    fill_in 'query', with: "light"
    fill_in 'location', with: ""
    fill_in 'category', with: ""
    click_button 'Search Equipment'
    expect(page).to have_content(@item3.title)
    expect(page).to_not have_content("heavy")
    expect(page).to_not have_content("Aluminum")
  end

  scenario 'searching for keyword in category' do
    fill_in 'query', with: @item3.title.split(" ").first
    fill_in 'location', with: ""
    fill_in 'category', with: @category1.name
    click_button 'Search Equipment'
    expect(page).to have_content("light")
    expect(page).to_not have_content("heavy")
    expect(page).to_not have_content("Aluminum")
  end

  scenario 'searching for keyword in category 2' do
    fill_in 'query', with: @item2.title.split(" ").first
    fill_in 'location', with: ""
    fill_in 'category', with: @category2.name
    click_button 'Search Equipment'
    expect(page).to have_content("Aluminum")
    expect(page).to_not have_content("mixer")
    expect(page).to_not have_content("Steel")
  end

  scenario 'searching for keyword in location' do
    fill_in 'query', with: @item4.title.split(" ").first
    fill_in 'location', with: @location2.name
    fill_in 'category', with: ""
    click_button 'Search Equipment'
    expect(page).to have_content("Steel")
    expect(page).to_not have_content("mixer")
    expect(page).to_not have_content("Aluminum")
  end

  scenario 'searching for all in a location' do
    fill_in 'query', with: ""
    fill_in 'location', with: @location2.name
    fill_in 'category', with: ""
    click_button 'Search Equipment'
    expect(page).to have_content(@item3.title)
    expect(page).to have_content(@item4.title)
    expect(page).to_not have_content(@item2.title)
    expect(page).to_not have_content(@item.title)
  end

  scenario 'searching for all in a category' do
    fill_in 'query', with: ""
    fill_in 'location', with: ""
    fill_in 'category', with: @category1.name
    click_button 'Search Equipment'
    expect(page).to have_content(@item.title)
    expect(page).to have_content(@item3.title)
    expect(page).to_not have_content(@item2.title)
    expect(page).to_not have_content(@item4.title)
  end

  scenario 'searching for all in a category and location' do
    fill_in 'query', with: ""
    fill_in 'location', with: @location2.name
    fill_in 'category', with: @category2.name
    click_button 'Search Equipment'
    expect(page).to have_content(@item4.title)
    expect(page).to_not have_content(@item.title)
    expect(page).to_not have_content(@item2.title)
    expect(page).to_not have_content(@item3.title)
  end
end
