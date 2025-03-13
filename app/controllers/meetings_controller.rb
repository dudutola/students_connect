class MeetingsController < ApplicationController
  def create
    @meeting = Meeting.new(meeting_params)

    if @meeting.save
      # redirect_to chapter_lecture_path(params[:lecture_id]), notice: "Meeting request sent!"
      redirect_to chapter_lecture_path(params[:chapter_id], params[:lecture_id]), notice: "Meeting request sent!"

    else
      # redirect_to chapter_lecture_path(params[:lecture_id]), alert: "Failed to send meeting request."
      redirect_to chapter_lecture_path(params[:chapter_id], params[:lecture_id]), notice: "Failed to send meeting request."
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:start_time, :end_time, :status, :requester_id, :receiver_id, :lecture_id)
  end
end
