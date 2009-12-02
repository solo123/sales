class QuotationsController < ApplicationController
  # GET /quotations
  # GET /quotations.xml
  def index
    @quotations = Quotation.all(:order => "id desc", :conditions => ["employee_id=? and (status is null or status<2)", session[:user_id]])
  end

  def list
    update_quotation_ref_ids
    @quotations = Quotation.all(:order => "id desc", :conditions => ["employee_id=? and (status is null or status<2)", session[:user_id]])
    render :partial => "quotation_list"
  end

  def submit_quotation
        sql = <<EOF
update quotations
set status=2
where status=1 and mobile_id>0 and employee_id=#{session[:user_id]}
EOF
    ActiveRecord::Base.connection.execute(sql)

    @quotations = Quotation.all(:order => "id desc", :conditions => ["employee_id=? and (status is null or status<2)", session[:user_id]])
    render :partial => "quotation_list"
  end

  # GET /quotations/1
  # GET /quotations/1.xml
  def show
    @quotation = Quotation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quotation }
    end
  end

  # GET /quotations/new
  # GET /quotations/new.xml
  def new
    @quotation = Quotation.new

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @quotation }
    end
  end

  # GET /quotations/1/edit
  def edit
    @quotation = Quotation.find(params[:id])
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  # POST /quotations
  # POST /quotations.xml
  def create
    pa = params[:quotation]
    pa[:status] ="0"
    pa[:employee_id] = session[:user_id]
    pa[:mobile_id] = '0'

    if Quotation.create(pa).valid?
      update_quotation_ref_ids
      
      @quotations = Quotation.all(:order => "id desc", :conditions => ["employee_id=? and (status is null or status<2)", session[:user_id]])
      render :partial => "quotation_list"
    else
      render :text => "something  wrong", :status => "500"
    end
  end

  # PUT /quotations/1
  # PUT /quotations/1.xml
  def update
    @quotation = Quotation.find(params[:id])
    pa = params[:quotation]
    pa[:employee_id] = session[:user_id]
    brand = Brand.find(:first, :conditions => ["short_name = ? or brand_name = ?", pa[:brand_short_name], pa[:brand_short_name]])
    pa[:brand_id] = brand ? brand.id : 0

    respond_to do |format|
      if @quotation.update_attributes(pa)
        flash[:notice] = "#{@quotation.brand_short_name}-#{@quotation.model_short_name} 报价已更新为 #{@quotation.quotation_price}。"
        format.html { render :action => "edit", :layout => false }
        format.xml  { head :ok }
      else
        flash[:notice] = "更新数据出错，请检查。"
        format.html { render :action => "edit", :layout => false }
        format.xml  { render :xml => @quotation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.xml
  def destroy
    @quotation = Quotation.find(params[:id])
    @quotation.destroy

    respond_to do |format|
      format.html { redirect_to(quotations_url) }
      format.xml  { head :ok }
    end
  end

  def delete
    Quotation.destroy(params[:id])
    @quotations = Quotation.find(:all)
    render :text => ""
  end
end

def update_quotation_ref_ids
    sql = <<EOF
update quotations, brands
set quotations.brand_id = brands.id
where
   quotations.status < 2 and
   (brands.short_name = quotations.brand_short_name or brands.brand_name = quotations.brand_short_name)
EOF
    ActiveRecord::Base.connection.execute(sql)
    sql = <<EOF
update quotations, mobiles
set quotations.mobile_id=mobiles.id, quotations.status=1
where
  (quotations.status is null or quotations.status=0)
  and mobiles.brand_id=quotations.brand_id
  and mobiles.model=quotations.model_short_name
EOF
    ActiveRecord::Base.connection.execute(sql)
  end