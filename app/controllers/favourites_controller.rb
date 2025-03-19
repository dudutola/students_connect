class FavouritesController < ApplicationController
  def index
    # @favourited_users = current_user.favourited_users
    @favourited_users = policy_scope(User).where(id: current_user.favourited_user_ids)
  end

  def toggle
    @user = User.find(params[:user_id])
    authorize @user

    if current_user.favourited_users.include?(@user)
      current_user.favourited_users.delete(@user)
      flash[:notice] = "Removed from favorites."
    else
      current_user.favourited_users << @user
      flash[:notice] = "Added to favorites."
    end

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite-icon-#{@user.id}", partial: "users/favorite_button", locals: { user: @user }) }
      format.html { redirect_to user_path(@user) }
    end
  end
end
