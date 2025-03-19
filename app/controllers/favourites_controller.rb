class FavouritesController < ApplicationController
  def toggle
    @user = User.find(params[:user_id])
    authorize @user

    if current_user.favourited_users.include?(@user)
      current_user.favourited_users.delete(@user)
    else
      current_user.favourited_users << @user
    end

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite-icon-#{@user.id}", partial: "users/favorite_button", locals: { user: @user }) }
      format.html { redirect_to user_path(@user) }
    end
  end
end
