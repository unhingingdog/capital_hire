class Location < ActiveRecord::Base
  has_many :items
  delegate :name, to: :class, prefix: true
end
