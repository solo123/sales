class AccountController < ApplicationController
  def reset
    @account = User.find(session[:user_id])
  end

  def index
    @account = User.find(session[:user_id])
  end

  def update
    @account = User.find(session[:user_id])

    respond_to do |format|
      if @account.update_attributes(params[:user])
        flash[:notice] = "用户 #{@account.nick_name} 资料更新成功。"
        format.html { render :action => :index}
        format.xml  { head :ok }
      else
        format.html { render :action => :account }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

end
