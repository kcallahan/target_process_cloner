FactoryGirl.define do
  factory :epic do
    name "an epic"
    owner 1 # Kevin Callahan in oittest TP
    numeric_priority 123 # Building Move Template's priority; this is EXTREMELY BRITTLE!
    source_remote_id 274
  end
end