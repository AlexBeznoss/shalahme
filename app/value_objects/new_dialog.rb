# frozen_string_literal: true

class NewDialog
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :content
  attribute :recipient_number
  attribute :user_number_id
  attribute :user
  attribute :errors

  def model_name
    Dialog.new.model_name
  end

  def user_numbers
    cache_key = "ready_numbers_for_#{user.id}"
    Rails.cache.fetch(cache_key, expires_in: 20 * 60) do
      user
        .phone_numbers
        .kept
        .ready
        .select(:id, :number, :name)
        .map { |n| ["#{n.name} (#{n.number})", n.id] }
    end
  end
end
