# frozen_string_literal: true

class CreateDialogs < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :dialogs do |t|
      t.references :user_phone_number, null: false, foreign_key: true
      t.references :recipient_phone_number, null: false, foreign_key: true
      t.integer :unread_messages_count, default: 0, null: false

      t.timestamps
    end

    add_index(
      :dialogs,
      %i[user_phone_number_id recipient_phone_number_id],
      unique: true,
      name: 'index_dialogs_unique_from_user_to_recipient'
    )
  end
end
