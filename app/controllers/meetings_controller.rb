class MeetingsController < ApplicationController
  before_action :set_meeting, only: [ :show, :accept, :decline, :cancel ]
  before_action :set_lecture, only: [ :create ]

  def index
    # @meetings = Meeting.where("requester_id = ? OR receiver_id = ?", current_user.id, current_user.id)
    @meetings = policy_scope(Meeting).order(created_at: :asc)

    @pending_meetings = @meetings.where(status: "pending")
    @accepted_meetings = @meetings.where(status: "accepted")
  end

  def show
    authorize @meeting
  end

  def create
    # @meeting = Meeting.new(meeting_params)
    @meeting = @lecture.meetings.new(meeting_params)
    authorize @meeting

    if @meeting.save
      # redirect_to lecture_path(@lecture.chapter, @lecture), notice: "Meeting request sent!"
      redirect_to @meeting, notice: "Meeting request sent!"
    else
      redirect_to lecture_path(@lecture.chapter, @lecture), alert: "Failed to send meeting request."
    end
  end

  def accept
    authorize @meeting

    if @meeting.update(status: "accepted")
      redirect_to dashboard_path, notice: "Meeting request accepted!"
    else
      redirect_to dashboard_path, alert: "Something went wrong."
    end
  end

  def decline
    authorize @meeting

    if @meeting.update(status: "declined")
      redirect_to dashboard_path, notice: "Meeting request declined!"
    else
      redirect_to dashboard_path, alert: "Something went wrong."
    end

  end

  def cancel
    authorize @meeting

    if @meeting.requester == current_user && @meeting.status == "pending"
      @meeting.destroy
      redirect_to dashboard_path, notice: "Meeting request canceled."
    else
      redirect_to dashboard_path, alert: 'You can only cancel your own pending requests.'
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:start_time, :end_time, :status, :requester_id, :receiver_id, :lecture_id)
  end

  def set_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end
end
