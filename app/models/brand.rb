class Brand < ActiveRecord::Base
  has_many :mobile

  validates_uniqueness_of :short_name
  validates_presence_of :short_name, :brand_name
  
  BRAND_STATUS = [
    ["有效", 1],
    ["新增品牌", 0],
    ["已删除", 7]
  ]

  # for use in drawdown list
  def refname
    na = self.short_name
    (8 - self.short_name.length).times { na << '.' }
    na << self.brand_name
  end

  
end
