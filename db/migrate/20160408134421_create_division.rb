class CreateDivision < ActiveRecord::Migration
  def change
    create_table :divisions, id: :uuid do |t|
      t.string :name,            null: false, default: ""
      t.timestamps               null: false
    end

    add_index :divisions, :id
  end
end
