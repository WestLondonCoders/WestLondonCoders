class YAMLint
  def initialize(pathname)
    @pathname = pathname
    @yaml_doc = File.read(pathname)
  end

  def lint
    unless linted == @yaml_doc
      raise 'YAMLint error: Run `rake lint:locale:fix` to fix the problem.'
    end
  end

  def lint!
    File.open(@pathname, 'w') { |f| f.write(linted) }
  end

private

  def linted
    comments = @yaml_doc.lines.grep(/^\s*#/).map(&:strip)
    config = copy(YAML.load(@yaml_doc))
    (comments + ['', YAML.dump(config)]) * "\n"
  end

  def copy(value)
    case value
    when Array then
      value.map(&method(:copy))
    when Hash then
      {}.tap do |hash|
        value.keys.sort.each { |key| hash[key] = copy(value[key]) }
      end
    else
      value
    end
  end
end

namespace :lint do
  desc "Lint en.yml"
  task :locale do
    en_locale = File.join(Rails.root, 'config', 'locales', 'en.yml')
    YAMLint.new(en_locale).lint
  end

  desc "Fix Lint errors in en.yml"
  task 'locale:fix' do
    en_locale = File.join(Rails.root, 'config', 'locales', 'en.yml')
    YAMLint.new(en_locale).lint!
  end

  desc "Lint JavaScript with JSHint"
  task :javascript do
    puts "Running JSHint:"
    succeeded = system("npm run lint --loglevel silent")

    if succeeded.nil?
      warn "Command failed: #{$?}."
      warn "Maybe Node.js and npm aren't installed? Try running `brew install node && npm install`."
      exit 1
    elsif succeeded == false
      warn "JSHint failed."
      exit 1
    else
      puts "JSHint succeeded."
    end
  end

  desc "Check JavaScript code style with JSCS"
  task :jscs do
    puts "Running JSCS:"
    succeeded = system("npm run jscs --loglevel silent")

    if succeeded.nil?
      warn "Command failed: #{$?}."
      warn "Maybe Node.js and npm aren't installed? Try running `brew install node && npm install`."
      exit 1
    elsif succeeded == false
      warn "JSCS failed."
      exit 1
    else
      puts "JSCS succeeded."
    end
  end

  desc "Lint SCSS with scss-lint"
  task "scss" do
    puts "Running scss-lint:"

    succeeded = system("scss-lint app/assets/stylesheets")

    if succeeded
      puts "No SCSS lints were found"
      puts "scss-lint succeeded"
    else
      warn "scss-lint failed."
      exit 1
    end
  end
end

# task lint: ['lint:locale', 'lint:javascript', 'lint:jscs', 'lint:scss']
task lint: ['lint:locale', 'lint:scss']
