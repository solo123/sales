class QuotationQueryController < ApplicationController
  # GET /quotations
  # GET /quotations.xml
  def index
    cnd = params[:query_cnd]
    if cnd != nil and cnd.length > 0
      flash[:notice] = "q=" + cnd
       @quotations = Quotation.paginate :page=> params[:page], :order => 'id', :conditions => ["model_short_name like ? or brand_short_name like ?", '%'+cnd+'%',cnd+'%']
    else
   @quotations = Quotation.paginate :page=> params[:page], :order => 'id'
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quotations }
    end
  end

end
