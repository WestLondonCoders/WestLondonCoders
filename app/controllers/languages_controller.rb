class LanguagesController < ApplicationController

  def index
    @search = Language.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @languages = @search.result
  end

  def search
    index
    render :index
  end

  def new
    @language = Language.new
  end

  def create
    @language = Language.new(language_params)

    respond_to do |format|
      if @language.save
        format.html { redirect_to languages_path, notice: 'Language created successfully.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def language_params
    params.require(:language).permit(:name)
  end
end
