module CourseHelper
  def step_number_classes(current_step, step)
    if step == current_step
      'a-step__number--current'
    elsif step.completed_by?(current_user)
      'a-step__number--complete'
    end
  end
end
