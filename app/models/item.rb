class Item < ActiveRecord::Base
  #associatons
  belongs_to :user
  belongs_to :category
  belongs_to :location
  has_many :orders

  #validations
  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :location_id, presence: true
  validates :rate, presence: true

  #paperclip
  has_attached_file :image, styles: { medium: "150x150>", thumb: "100x100>" },
                                      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 4.megabytes

  #maps stuff
  def full_address
    location ? self.address + ", " + self.location.name + ", " + "New Zealand" : self.address
  end
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  #postgresql search
  def self.text_search(query)
    if query.present?
      where("title @@ :q or description @@ :q", q: query)
    else
      # put something here
    end
  end

end
