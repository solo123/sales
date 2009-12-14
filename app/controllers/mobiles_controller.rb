class MobilesController < ApplicationController
  # GET /mobiles
  # GET /mobiles.xml
  def index
    conditions  = []
    arguments = {}

    unless params[:brand].blank?
      conditions << 'brand_id in (:brand)'
      arguments[:brand] = params[:brand]
    end

    unless params[:model].blank?
      conditions << '(name like :model)'
      arguments[:model] = "%#{params[:model]}%"
    end

    unless params[:remark].blank?
      conditions << '(part like :remark or remark like :remark)'
      arguments[:remark] = "%#{params[:remark]}%"
    end

    all_conditions = conditions.join(' AND ')
    @mobiles = Mobile.paginate :page=> params[:page], :order => 'id', :conditions => [all_conditions, arguments]
  end

  def list
    @mobiles = Mobile.all
  end

  def search
    @mobiles = Mobile.search(:params[:search])
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /mobiles/1
  # GET /mobiles/1.xml
  def show
    @mobile = Mobile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mobile }
    end
  end

  # GET /mobiles/new
  # GET /mobiles/new.xml
  def new
    @mobile = Mobile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mobile }
    end
  end

  # GET /mobiles/1/edit
  def edit
    @mobile = Mobile.find(params[:id])
  end

  # POST /mobiles
  # POST /mobiles.xml
  def create
    @mobile = Mobile.new(params[:mobile])

    respond_to do |format|
      if @mobile.save
        flash[:notice] = 'Mobile was successfully created.'
        format.html { redirect_to(@mobile) }
        format.xml  { render :xml => @mobile, :status => :created, :location => @mobile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mobile.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add
    r = false;
    Mobile.new do |m|
      m.brand_id = params[:brand_id]
      m.model = params[:model]
      m.remark = params[:remark] if params[:remark]
      m.price = params[:price]
      m.name = Brand.find(params[:brand_id]).brand_name << params[:model]
      r = m.save!

      respond_to do |format|
        format.html { render :text => "#{r}"}
        format.json { render :layout => false, :json => m.to_json }
      end
    end
  end

  # PUT /mobiles/1
  # PUT /mobiles/1.xml
  def update
    @mobile = Mobile.find(params[:id])

    respond_to do |format|
      if @mobile.update_attributes(params[:mobile])
        flash[:notice] = 'Mobile was successfully updated.'
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mobile.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /mobiles/1
  # DELETE /mobiles/1.xml
  def destroy
    @mobile = Mobile.find(params[:id])
    #@mobile.destroy

    respond_to do |format|
      format.html { redirect_to(mobiles_url) }
      format.xml  { head :ok }
    end
  end
end
