class CreateDelegate < ActiveRecord::Migration
  def change
    create_table :delegates, id: :uuid do |t|
      t.uuid :group_id,      null: false
      t.uuid :account_id,    null: false
      t.string :permission,  null: false, default: "observer"
      t.timestamps           null: false
    end

    add_index :delegates, [:group_id, :account_id], unique: true
  end
end
