class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics, id: :uuid do |t|
      t.string     :title,          null: false
      t.string     :description,                default: ""
      t.uuid       :author_id,      null: false
      t.uuid       :proposer_id,    null: false
      t.string     :proposer_type,  null: false
      t.boolean    :is_draft,                   default: true
      t.timestamp  :sended_at
      t.timestamps                  null: false
    end

    add_index :topics, [:proposer_id, :proposer_type]
  end
end
