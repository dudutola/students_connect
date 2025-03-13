class LecturesController < ApplicationController
  def index
    @lectures = policy_scope(Lecture)
  end

  def show
    @lecture = Lecture.find(params[:id])
    authorize @lecture
    @meeting = Meeting.new
  end

  def mark_as_done
    @lecutre = Lecture.find(params[:id])
    authorize @lecture

    LectureUser.find_or_create_by(user: current_user, lecture: @lecture)

    redirect_to @lecture, notice: "Lecture marked as done!"
  end
end
