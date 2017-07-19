class SessionsController < ApplicationController
  def new
  end
  
  def create
             
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    flash[:success] = "Welcome" + " " +  user.name + "!"
    
    #se o usuario for cliente somente para visualizar o dashboard de chamados
    if user.type_access == 'CALLCENTER' 

    redirect_to dashboard_servproject_path

    else         
    redirect_to root_path
    end
    else
      flash[:danger] = "Email ou Senha incorretos, por favor verifique os dados."
      redirect_to root_path
      #render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "See you soon!"
    redirect_to root_path
  end
  
end
