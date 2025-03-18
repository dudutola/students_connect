class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def skip_pundit?
    true
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = params[:user_id]  # User being reviewed
    @review.reviewer_id = current_user.id  # User giving the review
    
    if @review.save
      redirect_to user_path(@review.user), notice: "Review submitted successfully!"
    else
      redirect_to user_path(@review.user), alert: "Error: #{@review.errors.full_messages.join(", ")}"
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    user = @review.user
    
    # Only allow the review creator or an admin to delete
    if current_user == @review.reviewer || current_user.admin?
      @review.destroy
      redirect_to user_path(user), notice: "Review deleted successfully!"
    else
      redirect_to user_path(user), alert: "You don't have permission to delete this review."
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
