if Rails.env.development? || Rails.env.test?
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new do |task|
    task.options = %w[--display-cop-names]
  end

  task default: 'rubocop'
end
