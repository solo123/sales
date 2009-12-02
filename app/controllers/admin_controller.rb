class AdminController < ApplicationController


def login
  if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
          session[:user_id] = user.id
          session[:user_name] = user.nick_name
          session[:user_role] = user.role
          redirect_to(:controller => 'main', :action => "index" )
      else
          flash.now[:alert] = "用户名或密码不正确。"
      end
  end
end			  


def logout
  session[:user_id] = nil
  flash[:notice] = "您已退出登录。如需继续使用系统请重新登录。"
  redirect_to(:action => "login")
end

def index
end

end
