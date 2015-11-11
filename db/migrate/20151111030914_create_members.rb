class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :tenant, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
