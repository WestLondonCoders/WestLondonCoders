Rake::Task[:default].clear

task default: ['sitemap:refresh', 'lint', 'rubocop', 'spec:units', 'spec:features']
