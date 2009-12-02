class CreateMobiles < ActiveRecord::Migration
  def self.up
    create_table :mobiles do |t|
      t.integer :brand_id, :default=> 0
      t.string :name
      t.string :model
      t.string :part
      t.string :remark
      t.decimal :price, :precision=>8, :scale=>2, :default=>0
      t.integer :status, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :mobiles
  end
end
