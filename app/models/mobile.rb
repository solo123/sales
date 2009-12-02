class Mobile < ActiveRecord::Base
  belongs_to :brand
  has_one :mquotation
  
  validates_presence_of :model
  validates_numericality_of :price

  def self.find_mobile_for_wholesale
    find(:all, :order=>"model")
  end

end
