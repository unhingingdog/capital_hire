class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :location
  has_many :orders
  has_attached_file :image, styles: { medium: "150x150>", thumb: "100x100>" },
                                      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 4.megabytes

  #maps stuff
  def full_address
    self.address + ", " + self.location.name + ", " + "New Zealand"
  end
  geocoded_by :full_address
  after_validation :geocode

  #postgresql search
  def self.text_search(query)
    if query.present?
      where("title @@ :q or description @@ :q", q: query)
    else
      # put something here
    end
  end

end
