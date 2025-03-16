class ChaptersController < ApplicationController
  def index
    @chapters = policy_scope(Chapter)
  end

  def show
    @chapter = Chapter.find(params[:id])
    authorize @chapter
    @lectures = policy_scope(Lecture)

    # id qui soit plus petit que l id actuel

    # previous_chapter -> 30
    # -> 88
    # current_chapter -> 89

    # 88, 89, 90
    # [88,90, 123]
    # previous_chapter = Chapter.find_by(id: @chapter.id - 1)

    all_chapters = Chapter.all
    current_chapter_index = all_chapters.find_index(@chapter)
    @previous_chapter = all_chapters[current_chapter_index - 1]
    # @next_chapter = all_chapters[current_chapter_index + 1]
    # raise
    # @previous_chapter = Chapter.find_by("id < ?", @chapter.id)
    # @next_chapter = Chapter.find_by("id > ?", @chapter.id)
  end
end
