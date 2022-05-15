# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :users do |t|
      t.integer :role, null: false, default: 0
      t.string :email
      t.string :name
      t.string :logo_url
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
    end

    add_index :users, %i[provider uid], unique: true
    add_index :users, :email
  end
end
