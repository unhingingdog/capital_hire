class User < ActiveRecord::Base
  has_many :items
  has_many :borrows, class_name: "Order", foreign_key: "borrower_id"
  has_many :leases, class_name: "Order", foreign_key: "lessor_id"
  validates :phone, presence: true, length: { minimum: 7 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
