Rake::Task[:default].clear

task default: ['lint', 'rubocop', 'spec:units', 'spec:features']
