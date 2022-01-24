class AddLikeableToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :likeable, polymorphic: true
  end
end
