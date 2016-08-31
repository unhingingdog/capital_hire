class Order < ActiveRecord::Base
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :not_overlap
  belongs_to :item
  belongs_to :vendor, class_name: 'User'
  belongs_to :hirer, class_name: 'User'

  #return a scope for all intercal overlapping the given interval,
  #including the given interval itself
  scope :overlaps, ->(start_date, end_date) do
    where "((start_date <= ?) and (end_date >= ?))", end_date, start_date
  end

  #checks other orders on an item
  def other_orders
    item.orders.where('id != ?', id || -1)
  end

  #checks if the pending order overlaps with existing orders on that item,
  # using overlaps scope
  def overlaps
    other_orders.overlaps start_date, end_date
  end

  #returns true if an overlap exists
  def overlaps?
    overlaps.exists?
  end

  # callback method
  def not_overlap
    errors.add(:base, 'The item is not available on these dates.
     Please check the item calendar and try again.') if overlaps?
  end
end
