class SessionController < ApplicationController
  before_filter :require_login, only: [:destroy]

  def new
    @title = t('text.topbar.login')
  end

  def create
    user = User.find_by_name(params[:name])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: t('messages.login_successful')
    else
      flash.now.alert = t('messages.login_failure')
      @title = t('text.topbar.login')
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('messages.logout')
  end
end
