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

  #scopes
  scope :by_category, ->(category) { where('category_id = ?', category)}
  scope :by_location, ->(location) { where('location_id = ?', location)}

  #search/scopes
  def self.searcher(query, location, category)
    unless query.blank?
      item = SearchService.new(Item)
      if location == nil && category == nil
        items = item.search(query)
      elsif location == nil
        items = item.search(query).by_category(category)
      elsif category == nil
        items = item.search(query).by_location(location)
      else
        items = item.search(query).by_location(location).by_category(category)
      end
    else
      if location == nil && category == nil
        items = Item.all
      elsif location == nil
        items = Item.all.by_category(category)
      elsif category == nil
        items = Item.all.by_location(location)
      else
        items = Item.all.by_location(location).by_category(category)
      end
    end
  end

  #paperclip
  has_attached_file :image, styles: { medium: "150x150>", thumb: "100x100>" },
                                      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image,
                                          less_than: 4.megabytes

  #maps stuff

  def full_address
    self.location ? "#{self.address}, #{self.location.name}, New Zealand" : self.address
  end
  geocoded_by :full_address
  after_validation :geocode,
                    if: ->(obj){ obj.address.present? and obj.address_changed? }

end
