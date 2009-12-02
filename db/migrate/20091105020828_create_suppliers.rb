class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :short_name
      t.string :company_name
      t.string :contact_phone
      t.string :email
      t.string :address
      t.string :remark
      t.integer :status, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
