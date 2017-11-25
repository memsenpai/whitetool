class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.all
  end

  def new

  end

  def create
    @user = User.new user_param
    if @user.save
      flash[:success] = "Success, New user #{user_param[:email]}"
    else
      flash[:error] = "Some thing wrong, #{@user.errors.messages.first[0].to_s + ' ' + @user.errors.messages.first[1].join(' ,').to_s}"
    end
    respond_to do |format|
      format.html { redirect_to(users_path) }
      format.js
      format.xml  { render :xml => @person.to_xml(:include => @company) }
    end
  end

  def show

  end

  def destroy
    user = User.find_by_id params[:id]
    user.destroy
    flash[:notice] = "Delete #{user.email}"
    respond_to do |format|
      format.js {render "users/create.js.erb"}
    end
  end

  private

  def user_param
    params.require(:user).permit :email, :password, :password_confirmation
  end
end
