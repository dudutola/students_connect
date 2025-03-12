class LecturesController < ApplicationController
  def index
    @lectures = policy_scope(Lecture)
  end
end
