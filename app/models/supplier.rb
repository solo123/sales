class Supplier < ActiveRecord::Base
  validates_presence_of :short_name, :company_name, :contact_phone
end
