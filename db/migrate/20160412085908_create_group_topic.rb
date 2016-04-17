class CreateGroupTopic < ActiveRecord::Migration
  def change
    create_table :group_topics, id: :uuid do |t|
      t.uuid       :group_id,     null: false
      t.uuid       :topic_id,     null: false
      t.datetime   :last_read_at
      t.timestamps                null: false
    end

    add_index :group_topics, [:group_id, :topic_id]
    add_index :group_topics, :last_read_at
  end
end
