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
    address '1 Colombo Street'
    latitude -43.5687040802915
    longitude 172.6335858697085
  end
end
