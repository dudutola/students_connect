class LecturesController < ApplicationController
  def show
    @lecture = Lecture.find(params[:id])
    authorize @lecture
    @meeting = Meeting.new
    @users = @lecture.lecture_users.where.not(user: current_user).map(&:user)
  end

  def mark_as_done
    @lecture = Lecture.find(params[:id])
    authorize @lecture

    lecture_user = @lecture.lecture_users.find_by(user: current_user)

    if lecture_user
      lecture_user.destroy
      flash[:notice] = "Lecture marked as not completed."
    else
      @lecture.lecture_users.create(user: current_user)
      flash[:notice] = "Lecture marked as completed!"
    end

    redirect_to @lecture, notice: "Lecture marked as done!"
  end
end
