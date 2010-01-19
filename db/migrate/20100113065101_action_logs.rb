class ActionLogs < ActiveRecord::Migration
  def self.up 
    create_table :action_logs do |t|
      t.column :userid,     :int
      t.column :controller, :string 
      t.column :action,     :string
      t.column :paraid,     :string 
      t.column :start_time, :datetime
      t.column :end_time,   :datetime
      t.column :total,      :float
    end
  end

  def self.down
    drop_table :action_logs
  end
end
