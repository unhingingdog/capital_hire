class Item < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "400x400>", thumb: "200x200>" },
                                      default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 4.megabytes
end
