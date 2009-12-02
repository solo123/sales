class WholesaleController < ApplicationController
  def index
    
    @products = Mobile.find_mobile_for_wholesale
    
  end

end
