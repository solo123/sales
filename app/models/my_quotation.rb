# To change this template, choose Tools | Templates
# and open the template in the editor.

class MyQuotation
  def initialize
    
  end

  def self.find_my_quotations
    MyQuotation.find_by_sql("select * from quotations where status<2")
  end
end
