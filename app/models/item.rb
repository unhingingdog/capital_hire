class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :location
  has_attached_file :image, styles: { medium: "400x400>", thumb: "200x200>" },
                                      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 4.megabytes

  def self.text_search(query)
    if query.present?
      where("title @@ :q or description @@ :q", q: query)
    else

    end
  end

end
