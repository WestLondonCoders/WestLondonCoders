class StepsController < ApplicationController
  before_action :find_course
  before_action :find_step, only: [:show, :edit, :update, :destroy, :next, :finish]
  load_and_authorize_resource
  before_action :require_sign_in

  def index
    @steps = @course.steps.all
  end

  def new
    @step = @course.steps.new
  end

  def create
    @step = @course.steps.new(step_params)
    respond_to do |format|
      if @step.save
        format.html { redirect_to course_step_path(@course, @step), notice: 'Step added.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to course_step_path(@course, @step), notice: 'Course updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to course_path(@course) }
    end
  end

  def next
    @step_completion = StepCompletion.find_or_create_by(user: current_user, step: @step)
    redirect_to course_step_path(@course, (@step.position + 1))
  end

  def finish
    @step_completion = StepCompletion.find_or_create_by(user: current_user, step: @step)
    redirect_to @course
  end

  private

  def find_course
    @course = Course.friendly.find(params[:course_id])
  end

  def find_step
    @step = Step.friendly.find(params[:id])
  end

  def step_params
    params.require(:step).permit(:title, :position, :content)
  end
end
