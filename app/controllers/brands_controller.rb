class BrandsController < ApplicationController
  # GET /brands
  # GET /brands.xml
  def index
    @brands = Brand.all(:conditions => "status<2", :order => "short_name")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @brands }
    end
  end

  # GET /brands/1
  # GET /brands/1.xml
  def show
    @brand = Brand.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @brand }
    end
  end

  # GET /brands/new
  # GET /brands/new.xml
  def new
    @brand = Brand.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @brand }
    end
  end

  # GET /brands/1/edit
  def edit
    @brand = Brand.find(params[:id])
  end

  # POST /brands
  # POST /brands.xml
  def create
    @brand = Brand.new(params[:brand])
    @brand.status = 1
    respond_to do |format|
      if @brand.save
        flash[:notice] = "新增品牌 <b>#{@brand.brand_name}</b>"
        format.html { redirect_to(:action => :index) }
        format.xml  { render :xml => @brand, :status => :created, :location => @brand }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @brand.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /brands/1
  # PUT /brands/1.xml
  def update
    @brand = Brand.find(params[:id])

    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        flash[:notice] = "品牌 <b>#{@brand.brand_name}</b> 更新成功。"
        format.html { redirect_to(:action => :index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @brand.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.xml
  def destroy
    @brand = Brand.find(params[:id])
    @brand.status = 7
    @brand.save
    respond_to do |format|
      format.html { redirect_to(brands_url) }
      format.xml  { head :ok }
    end
  end

  # Don't forget to edit routes if you're using RESTful routing (see config/routes.rb)
  def post_data
    # It's of course your role to add security / validation here
    if params[:oper] == "del"
      #User.find(params[:id]).destroy
    else
        brand = Brand.new(params[:brand])
        if brand.valid? && brand.save
          render :text => "success"
        else
          render :text => "添加品牌出错，请检查是否缩写重复。"
        end
    end
  end

end
