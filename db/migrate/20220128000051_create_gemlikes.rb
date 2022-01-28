class CreateGemlikes < ActiveRecord::Migration[6.1]
  def change
    create_table :gemlikes do |t|
      t.bigint :gemlikeable_id
      t.string :gemlikeable_type

      t.timestamps
    end

    add_index :gemlikes, [:gemlikeable_type, :gemlikeable_id]
  end
end
