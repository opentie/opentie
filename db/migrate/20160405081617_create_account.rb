class CreateAccount < ActiveRecord::Migration
  def change
    create_table :accounts, id: :uuid do |t|
      t.string   :kibokan_id,            null: false
      t.string   :email,                              default: nil
      t.string   :password_digest,       null: false, default: ""
      t.boolean  :is_admin,                           default: false
      t.timestamps                       null: false
    end

    add_index :accounts, :kibokan_id
    add_index :accounts, :email
  end
end
