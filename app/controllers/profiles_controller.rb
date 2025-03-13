class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @current_user = current_user
    @user = User.find(params[:id])
  end
end
