class LanguagesController < ApplicationController
  before_action :find_language, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :destroy, :create, :update]

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

  def update
    respond_to do |format|
      if @language.update(language_params)
        format.html { redirect_to @language, notice: 'Language was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @language.destroy
    respond_to do |format|
      format.html { redirect_to languages_path, notice: 'Language deleted.' }
    end
  end

  private

  def find_language
    @language = Language.find(params[:id])
  end

  def language_params
    params.require(:language).permit(:name)
  end
end
