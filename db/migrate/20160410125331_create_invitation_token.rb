class CreateInvitationToken < ActiveRecord::Migration
  def change
    create_table :invitation_tokens, id: :uuid do |t|
      t.string  :token,             null: false
      t.uuid    :organization_id,   null: false
      t.string  :organization_type, null: false
      t.boolean :is_active,                     default: false
      t.string  :email,             null: false
      t.timestamps                  null: false
    end

    add_index :invitation_tokens, :token
  end
end
