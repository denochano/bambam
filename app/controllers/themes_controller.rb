class ThemesController < ApplicationController
  def index
    @themes = Theme.all
  end

  def show
  end

  def new
  end

  def create
  end
end
