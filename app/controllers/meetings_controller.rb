class MeetingsController < ApplicationController
  before_action :set_lecture, only: [ :create ]

  def index
    # @meetings = Meeting.where("requester_id = ? OR receiver_id = ?", current_user.id, current_user.id)
    @meetings = policy_scope(Meeting)
  end

  def show
    @meeting = Meeting.find(params[:id])
    authorize @meeting
  end

  def create
    # @meeting = Meeting.new(meeting_params)
    @meeting = @lecture.meetings.new(meeting_params)
    authorize @meeting

    if @meeting.save
      redirect_to lecture_path(@lecture.chapter, @lecture), notice: "Meeting request sent!"
    else
      redirect_to lecture_path(@lecture.chapter, @lecture), alert: "Failed to send meeting request."
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:start_time, :end_time, :status, :requester_id, :receiver_id, :lecture_id)
  end

  def set_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end
end
