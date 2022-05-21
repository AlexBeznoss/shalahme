# frozen_string_literal: true

class CreateRecipientPhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :recipient_phone_numbers do |t|
      t.string :number

      t.timestamps
    end

    add_index :recipient_phone_numbers, :number, unique: true
  end
end
