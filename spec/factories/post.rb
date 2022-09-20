# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user
    title { 'Post A' }
    description { 'Description of Post A' }
  end
end
