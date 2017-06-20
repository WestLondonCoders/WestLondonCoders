class CoursesController < ApplicationController
  before_action :find_course, except: [:index, :new, :create]

  def index
    @courses = Course.published
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.author = current_user
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def publish
    @course.update(published_at: Time.now) unless @course.published?
    redirect_to @course
  end

  private

  def find_course
    @course = Course.friendly.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, language_ids: [])
  end
end

