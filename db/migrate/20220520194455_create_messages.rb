# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :messages do |t|
      t.string :content, null: false
      t.boolean :read, null: false, default: false
      t.string :media_urls, array: true, default: []
      t.references :dialog, null: false, foreign_key: true
      t.string :sid
      t.integer :status, null: false, default: 0
      t.integer :direction, null: false, default: 0
      t.integer :kind, null: false
      t.integer :num_segments

      t.timestamps
    end

    add_index :messages, :sid, unique: true, where: 'sid IS NOT NULL'
  end
end
