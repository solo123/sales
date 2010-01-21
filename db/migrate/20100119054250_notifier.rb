class Notifier < ActiveRecord::Migration
  def self.up 
    create_table :notifiers do |t|
      t.column :ntype,      :string
      t.column :member_id,  :int
      t.column :address,    :string
      t.column :subject,    :string
      t.column :message,    :string
      t.column :send_date,  :datetime
      t.column :sent_date,  :datetime
      t.column :status,     :int, :default => 0
    end
  end

  def self.down
    drop_table :notifiers
  end
end
