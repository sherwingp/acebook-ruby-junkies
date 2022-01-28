class AddGemlikeableToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :gemlikeable, polymorphic: true
  end
end
