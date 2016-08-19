FactoryGirl.define do
  factory :item do
    title "10 fence"
    description "chainlink fences"
    image_file_name "dog.jpg"
    specs "10x"
    category_id 2
    user_id 1
    location_id 1
    rate 70
  end
end
