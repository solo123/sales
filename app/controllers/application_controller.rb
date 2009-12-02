# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	before_filter :authorize, :except => :login
	helper :all # include all helpers, all the time

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
protected


	def authorize
    unless session[:user_id]
      flash[:notice] = "请登录"
      redirect_to :controller => 'admin', :action => 'login'
    end
  end
=begin
		unless User.find_by_id(session[:user_id])
      flash[:notice] = "请登录"
      redirect_to :controller => 'admin', :action => 'login'
		end
=end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :action => "index" })
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

end
