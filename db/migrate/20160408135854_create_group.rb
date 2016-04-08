class CreateGroup < ActiveRecord::Migration
  def change
    create_table :groups, id: :uuid do |t|
      t.integer :kibokan_id,   null: false
    end

    add_index :groups, :kibokan_id
  end
end
