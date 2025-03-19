class FavouritesController < ApplicationController
  def index
    # @favourited_users = current_user.favourited_users
    # @favourited_users = policy_scope(User).where(id: current_user.favourited_user_ids)
    @favourites = policy_scope(current_user.favourites.where(user: current_user))
  end

  def toggle
    @user = current_user
    @lecture_user = User.find(params[:user_id])
    authorize @user

    # debugger
    if current_user.favourites.find_by(favourited_user: @lecture_user)

      Favourite.find_by(favourited_user: @lecture_user).destroy
      # current_user.favourited_users.delete(@user)
      # @removed = true
    else
      Favourite.create!(user: @user, favourited_user: @lecture_user)
      # current_user.favourited_users << @user
      # @removed = false
    end

    # respond_to do |format|
    #   format.turbo_stream do
    #     if params[:from] == "index"
    #       render turbo_stream: turbo_stream.replace("favourited-users", partial: "favourites/favourited_users", locals: { favourited_users: current_user.favourited_users })
    #     else
    #       render turbo_stream: turbo_stream.replace("favorite-icon-#{@user.id}", partial: "users/favorite_button", locals: { user: @user })
    #     end
    #   end
    #   format.html { redirect_to user_favourites_path(current_user) }
    # end
  end
end
