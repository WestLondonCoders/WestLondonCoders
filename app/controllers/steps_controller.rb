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
    @position_field = @course.steps.count + 1
  end

  def edit
    @position_field = @step.position
  end

  def create
    @step = @course.steps.new(step_params)
    if @step.save
      flash[:notice] = 'Step added.'
      redirect_to course_step_path(@course, @step)
    else
      flash[:notice] = 'Please check the fields in red.'
      render :new
    end
  end

  def update
    if @step.update(step_params)
      @step.update(slug: @step.position)
      flash[:notice] = 'Step updated.'
      redirect_to course_step_path(@course, @step), notice: 'Course updated.'
    else
      flash[:notice] = 'Please check the fields in red.'
      render :edit
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
    @step = Step.find_by(position: params[:id], course: @course)
  end

  def step_params
    params.require(:step).permit(:title, :position, :content)
  end
end
