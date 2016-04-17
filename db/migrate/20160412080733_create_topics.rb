class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics, id: :uuid do |t|
      t.string     :title,          null: false
      t.string     :description,                default: ""
      t.uuid       :account_id,     null: false
      t.uuid       :proposer_id,    null: false
      t.string     :proposer_type,  null: false
      t.timestamps                  null: false
    end

    add_index :topics, [:proposer_id, :proposer_type]
  end
end
