class CreateDelegate < ActiveRecord::Migration
  def change
    create_table :delegates, id: :uuid do |t|
      t.uuid :group_id,      null: false
      t.uuid :account_id,    null: false
      t.string :permission,  null: false, default: "normal"
      t.timestamps           null: false
    end

    add_index :delegates, :group_id
    add_index :delegates, :account_id
  end
end
