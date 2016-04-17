class CreateRole < ActiveRecord::Migration
  def change
    create_table :roles, id: :uuid do |t|
      t.uuid :account_id,      null: false
      t.uuid :division_id,     null: false
      t.string :permission,    null: false, default: "normal"
      t.timestamps             null: false
    end

    add_index :roles, [:account_id, :division_id], unique: true
  end
end
