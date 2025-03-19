class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :ensure_current_user, only: [:edit, :update]

  def skip_pundit?
    true
  end

  def show
    @reviews = @user.reviews.order(created_at: :desc)
  end

  def edit; end

  def update
    # Special handling for skills array (if applicable)
    if params[:user] && params[:user][:skills].is_a?(Array)
      if params[:user][:skills].length == 1 && params[:user][:skills][0].blank?
        params[:user][:skills] = []
      else
        params[:user][:skills].reject!(&:blank?)
      end
    end

    if @user.update(user_params)
      # Broadcasting the timezone update (if needed)
      # This line will notify Turbo Streams to update the timezone on the page
      # The broadcasting logic should already be handled in the User model (after_update_commit)
      redirect_to user_profile_path(@user), notice: "Your profile has been successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def timezone
    @user = User.find(params[:id])
    # Return the current time for the user in their specified timezone
    render plain: Time.now.in_time_zone(params[:timezone] || "UTC").strftime("%I:%M %p")
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:description, :github_url, :linkedin_url, :slack_url, :skills, :timezone)
  end

  def ensure_current_user
    unless current_user.id.to_s == params[:id]
      redirect_to user_profile_path(current_user), alert: "You can only edit your own profile."
    end
  end
end
