FactoryGirl.define do
  factory :user_story do
    name "A user story"
    owner 1 # Kevin Callahan in oittest TP
    numeric_priority 468 
    source_remote_id 872
  end
end