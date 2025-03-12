class ChaptersController < ApplicationController
  def index
    @chapters = Chapter.all
  end
end
