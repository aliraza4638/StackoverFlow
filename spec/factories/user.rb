# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'c@c.com' }
    password { '111111' }
  end
end
