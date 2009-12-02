class AddRemarkToQuotation < ActiveRecord::Migration
  def self.up
    add_column :quotations, :remark, :string
  end

  def self.down
    remove_column :quotations, :remark
  end
end
