class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :users, null: false, foreign_key: true
      t.text :about

      t.timestamps
    end
  end
end
