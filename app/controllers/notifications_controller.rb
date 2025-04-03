class NotificationsController < ApplicationController

  # def mark_as_read
  #   skip_authorization
  #   @notification = Notification.find(params[:id])

  #   if @notification.update(read: true)
  #     respond_to do |format|
  #       format.turbo_stream
  #       format.html { redirect_to dashboard_path, notice: "Notification was successfully updated." }
  #     end
  #   else
  #     render turbo_stream: turbo_stream.replace(
  #       @notification,
  #       partial: "notifications/notification",
  #       locals: { notification: @notification }
  #     )
  #   end
  # end

  def mark_as_read
    skip_authorization

    @notification = Notification.find(params[:id])
    if @notification.update(read: true)
      redirect_to dashboard_path, notice: "Notification was successfully updated."
    end



=begin
    if @notification.update(read: true)
      respond to format
      format.turbo_stream to delete (search)
      format.html {head :no_content}
    else
      render turbo_stream: turbo_stream.replace with notication, notice: with errors
    end
=end

# format.turbo_stream do
#   render turbo_stream: turbo_stream.append(
#     :messages,
#     partial: "messages/message",
#     target: "messages",
#     locals: { message: @message, user: current_user }
#   )
# end
# format.html { redirect_to booking_path(@booking) }
# end
# else
# render "bookings/show", status: :unprocessable_entity
# end

  end
end
