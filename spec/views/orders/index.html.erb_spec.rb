require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        :address => "Address",
        :phone => "Phone",
        :email => "Email"
      ),
      Order.create!(
        :address => "Address",
        :phone => "Phone",
        :email => "Email"
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
