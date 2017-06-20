class StepCompletion < ActiveRecord::Base
  belongs_to :step
  belongs_to :user
end
