require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :address => "MyString",
      :phone => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_address[name=?]", "order[address]"

      assert_select "input#order_phone[name=?]", "order[phone]"

      assert_select "input#order_email[name=?]", "order[email]"
    end
  end
end
