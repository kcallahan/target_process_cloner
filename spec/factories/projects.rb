FactoryGirl.define do
  factory :project do
    name "A test project"
    owner 1 # Kevin Callahan in oittest TP
    numeric_priority 50 # Building Move Template's priority; this is EXTREMELY BRITTLE!
    source_remote_id 191 # Building Move Template project in oittest"
  end

  initialize_with { new({:source_remote_id => 191}) }
end