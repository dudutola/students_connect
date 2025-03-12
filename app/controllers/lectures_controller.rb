class LecturesController < ApplicationController
  def index
    @lectures = Lecture.all
  end
end
