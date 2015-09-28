FactoryGirl.define do
  factory :remote_entity, class:Hash do
    name "Building Move Template"
    resource_type "Project"
    owner {{ "id" => 1 }} # Kevin Callahan in oittest TP
    numeric_priority 49 # Building Move Template's priority; this is EXTREMELY BRITTLE!
    description "this project will be amazing"

    initialize_with {attributes}
  end
end