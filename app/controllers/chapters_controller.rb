class ChaptersController < ApplicationController
  def index
    @chapters = policy_scope(Chapter)
  end

  def show
    @chapter = Chapter.find(params[:id])
    authorize @chapter
    @lectures = policy_scope(Lecture).where(chapter: @chapter)
  end
end
