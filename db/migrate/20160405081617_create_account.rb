class CreateAccount < ActiveRecord::Migration
  def change
    create_table :accounts, id: :uuid do |t|
      t.integer :kibokan_id,            null: false
      t.string  :email,                 null: false, default: ""
      t.string  :password_digest,       null: false, default: ""
      t.boolean :confirmed_email,                    default: false
      t.string  :confirmation_token
      t.timestamps                      null: false
    end

    add_index :accounts, :kibokan_id
    add_index :accounts, :email
  end
end
