class CreateMquotations < ActiveRecord::Migration
  def self.up
    create_table :mquotations do |t|
      t.column :mobile_id, :integer
      t.column :price, :decimal, :precision => 8, :scale => 2
      t.column :date, :datetime
    end
  end

  def self.down
    drop_table :mquotations
  end
end
