class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts, id: :uuid do |t|
      t.string     :body,                       default: ""
      t.uuid       :topic_id,       null: false
      t.uuid       :author_id,      null: false
      t.uuid       :group_id,       null: false
      t.boolean    :is_draft,                   default: false
      t.timestamps                  null: false
    end

    add_index :posts, :topic_id
    add_index :posts, :group_id
  end
end
