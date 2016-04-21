class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts, id: :uuid do |t|
      t.string     :body,                        default: ""
      t.uuid       :author_id,        null: false
      t.uuid       :division_id,      null: false
      t.uuid       :group_topic_id,   null: false
      t.boolean    :is_draft,                     default: false
      t.timestamp  :sended_at
      t.timestamps                    null: false
    end

    add_index :posts, :is_draft
    add_index :posts, :group_topic_id
  end
end
