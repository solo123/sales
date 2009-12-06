class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :company
      t.string :name
      t.string :mobile
      t.string :phone
      t.string :email
      t.string :qq
      t.string :pin
      t.integer :level, :default => 0
      t.integer :status, :default => 0
      t.datetime :last_login

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
