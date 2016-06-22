class Order < ActiveRecord::Base
  validates :address, :phone, :email, presence: true
  belongs_to :item
  belongs_to :vendor, class_name: 'User' 
  belongs_to :hirer, class_name: 'User'
end
