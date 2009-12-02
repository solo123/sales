class CreateBrands < ActiveRecord::Migration
  def self.up
    create_table :brands do |t|
      t.string :short_name
      t.string :brand_name
      t.integer :status, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :brands
  end
end
