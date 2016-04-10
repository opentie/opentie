class CreatePasswordRecoveryToken < ActiveRecord::Migration
  def change
    create_table :password_recovery_tokens, id: :uuid do |t|
      t.string  :token,         null: false
      t.uuid    :account_id,    null: false
      t.boolean :is_active,                 default: false
      t.timestamps              null: false
    end

    add_index :password_recovery_tokens, :token
  end
end
