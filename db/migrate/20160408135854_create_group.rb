class CreateGroup < ActiveRecord::Migration
  def change
    create_table :groups, id: :uuid do |t|
      t.string    :kibokan_id,    null: false
      t.string    :category_name, null: false
      t.timestamp :frozen_at,                 default: nil
      t.timestamps                null: false
    end

    add_index :groups, :kibokan_id
  end
end
