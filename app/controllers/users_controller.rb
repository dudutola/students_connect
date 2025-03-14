class UsersController < ApplicationController

  def skip_pundit?
    true
  end

  def show
    @user = User.find(params[:id])
  end
end
