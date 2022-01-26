# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :message
      t.timestamps
      t.references :user, null: false, foreign_key: true
    end
  end
end
