class AddUserRefToGemlikes < ActiveRecord::Migration[6.1]
  def change
    add_reference :gemlikes, :user, null: false, foreign_key: true
  end
end
