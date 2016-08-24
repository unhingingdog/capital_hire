require 'spec_helper'
require 'rails_helper'

feature 'creating orders' do
  before do
    visit '/'
    user = FactoryGirl.create(:user)
    hirer = FactoryGirl.create(:user, email: "hirer@example.com",
                               phone: '09876543')
    item = FactoryGirl.create(:item, user_id: user.id + 1, title: "heavy mixer")
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'can create order' do
    fill_in 'query', with: 'heavy mixer'
    click_button 'Search Equipment'
    click_link 'heavy mixer'
    click_link 'Hire now'

    expect(page).to have_content("New Order")
    fill_in 'Details of job', with: 'Using to mix concrete for fencing'
    select('April', from: 'order[start_date(2i)]')
    select('1', from: 'order[start_date(3i)]')
    select('2018', from: 'order[start_date(1i)]')
    select('May', from: 'order[end_date(2i)]')
    select('4', from: 'order[end_date(3i)]')
    select('2018', from: 'order[end_date(1i)]')
    click_button 'Create Order'

    expect(page).to have_no_content("errors prohibited")
    expect(page).to have_content("order shit")
  end
end
