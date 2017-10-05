class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: %i(update destroy)
  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    render json: {users: User.select(:id, :email).as_json}
  end

  def show
    respond_with User.find(params[:id])
  end

  def update
    user = current_user

    return render json: {errors: user.errors}, status: 422 unless user.update(user_params)
    render json: user, status: 200, location: [:api, user]
  end

  def destroy
    current_user.destroy
    head 204
  end
end
