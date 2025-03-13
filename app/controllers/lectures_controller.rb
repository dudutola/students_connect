class LecturesController < ApplicationController
  def index
    @lectures = policy_scope(Lecture)
  end

  def show
    @lecture = Lecture.find(params[:id])
    authorize @lecture
  end
end
