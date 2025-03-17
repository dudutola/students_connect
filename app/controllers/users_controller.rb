class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :ensure_current_user, only: [:edit, :update]
  
  def skip_pundit?
    true
  end
  
  def show
    # Your existing show action
  end
  
  def edit
    # Just renders the edit form
  end
  
  def update
    # Special handling for skills array
    if params[:user] && params[:user][:skills].is_a?(Array)
      # If only an empty string was submitted, convert to empty array
      if params[:user][:skills].length == 1 && params[:user][:skills][0].blank?
        params[:user][:skills] = []
      else
        # Otherwise, remove any blank entries
        params[:user][:skills].reject!(&:blank?)
      end
    end
    
    if @user.update(user_params)
      redirect_to user_profile_path(@user), notice: "Your profile has been successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    # The skills array will be handled by the serialize method in the model
    params.require(:user).permit(:description, :github_url, :linkedin_url, skills: [])
  end
  
  def ensure_current_user
    unless current_user.id.to_s == params[:id]
      redirect_to user_profile_path(current_user), alert: "You can only edit your own profile."
    end
  end
end


