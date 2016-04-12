class CreateTopicsGroups < ActiveRecord::Migration
  def change
    create_table :topics_groups, id: :uuid do |t|
      t.uuid       :group_id,     null: false
      t.uuid       :topic_id,     null: false
      t.timestamps                null: false
    end

    add_index :topics_groups, [:group_id, :topic_id]
  end
end
