class ThemesController < ApplicationController
  def index
    @themes = current_user.themes
  end

  def show
  end

  def new
  end

  def create
  end
end
