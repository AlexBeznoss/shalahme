# frozen_string_literal: true

class CreateUserPhoneNumbers < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :user_phone_numbers do |t|
      t.string :name, null: false
      t.string :number
      t.string :sid
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.string :area_code, null: false
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :user_phone_numbers, :discarded_at, where: 'discarded_at IS NULL'
    add_index :user_phone_numbers, %i[user_id name], where: 'discarded_at IS NULL', unique: true
  end
end
