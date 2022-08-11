# frozen_string_literal: true

FactoryBot.define do
  factory :synonym do
    authorized { true }
    value { 'neat' }
  end
end
