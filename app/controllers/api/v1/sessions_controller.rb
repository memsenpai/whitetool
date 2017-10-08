class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by_email(user_email)

    return render json: {errors: "Invalid email or password"}, status: 422 unless user.valid_password? user_password
    sign_in user, store: false
    user.generate_authentication_token!
    user.save
    render json: user, status: 200, location: [:api_v1, user]
  end

  def destroy
    user = User.find_by_auth_token params[:id]
    user.generate_authentication_token!
    user.save
    head 204
  end
end
# git basic
# git basic 2
