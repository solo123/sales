class CreateQuotations < ActiveRecord::Migration
  def self.up
    create_table :quotations do |t|
      t.integer :supplier_id, :default => 0
      t.integer :brand_id, :default => 0
      t.integer :mobile_id, :default =>0
      t.string :brand_short_name
      t.string :model_short_name
      t.decimal :quotation_price,  :precision=>8, :scale=>2, :default=>0
      t.integer :employee_id
      t.datetime :quotation_date
      t.integer :status, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :quotations
  end
end
