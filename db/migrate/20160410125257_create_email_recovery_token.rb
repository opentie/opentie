class CreateEmailRecoveryToken < ActiveRecord::Migration
  def change
    create_table :email_recovery_tokens, id: :uuid do |t|
      t.string  :token,         null: false
      t.uuid    :account_id,    null: false
      t.boolean :is_active,                 default: false
      t.string  :email,         null: false
      t.timestamps              null: false
    end

    add_index :email_recovery_tokens, :token
  end
end
