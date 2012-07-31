# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incident_history do
    comment "MyText"
    raised_on "2012-07-28 23:07:33"
    user_audit "MyText"
  end
end
