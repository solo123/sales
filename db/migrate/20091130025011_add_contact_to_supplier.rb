class AddContactToSupplier < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :contact, :string
  end

  def self.down
    remove_column :suppliers, :contact
  end
end
