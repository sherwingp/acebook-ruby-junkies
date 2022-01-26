class AddLikeableToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :likeable, polymorphic: true
  end
end
