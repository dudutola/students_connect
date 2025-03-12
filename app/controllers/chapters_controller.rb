class ChaptersController < ApplicationController
  def index
    @chapters = policy_scope(Chapter)
  end
end
