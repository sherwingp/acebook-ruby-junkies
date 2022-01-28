class AddGemlikeableToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :gemlikeable, polymorphic: true
  end
end
