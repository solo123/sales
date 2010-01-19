class ForgotPsw < ActiveRecord::Migration
  def self.up 
    create_table :forgot_psws do |t|
      t.column :user_mobile,:string
      t.column :pin,        :string 
      t.column :date,       :datetime
      t.column :send_by,    :string 
      t.column :request_ip, :datetime
      t.column :status,     :int, :default => 0
    end
  end

  def self.down
    drop_table :forgot_psws
  end
end
