class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics, id: :uuid do |t|
      t.string     :name,           null: false
      t.string     :description,                default: ""
      t.uuid       :proposer_id,    null: false
      t.timestamps                  null: false
    end

    add_index :topics, :id
    add_index :topics, :proposer_id
  end
end
