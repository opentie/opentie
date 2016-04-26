class CreateGroup < ActiveRecord::Migration
  def change
    create_table :groups, id: :uuid do |t|
      t.string :kibokan_id,   null: false
      t.string :category_id,  null: false
    end

    add_index :groups, :kibokan_id
  end
end
