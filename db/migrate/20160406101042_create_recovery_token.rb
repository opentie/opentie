class CreateRecoveryToken < ActiveRecord::Migration
  def change
    create_table :recovery_tokens, id: :uuid do |t|
      t.string  :token,         null: false
      t.uuid    :account_id,    null: false
      t.boolean :is_active,                 default: false
      t.string  :type,                      default: ""
      t.string  :substitute,                default: ""
      t.timestamps              null: false
    end

    add_index :recovery_tokens, :token
    add_index :recovery_tokens, :type
  end
end
