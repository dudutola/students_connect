class ChaptersController < ApplicationController
  def index
    @chapters = policy_scope(Chapter)
  end

  def show
    @chapter = Chapter.find(params[:id])
    authorize @chapter
    @lectures = policy_scope(Lecture.where(chapter: @chapter))

    all_chapters = Chapter.all
    current_chapter_index = all_chapters.find_index(@chapter)
    @previous_chapter = all_chapters[current_chapter_index - 1] if current_chapter_index > 0
    @next_chapter = all_chapters[current_chapter_index + 1] if current_chapter_index < all_chapters.length - 1

#     @lectures = policy_scope(Lecture).where(chapter: @chapter)
  end
end
