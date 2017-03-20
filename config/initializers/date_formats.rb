Time::DATE_FORMATS[:default] = "%m %d %Y at %I:%M%p"
Time::DATE_FORMATS[:day_long_ordinal] = ->(date) {
  day_format = ActiveSupport::Inflector.ordinalize(date.day)
  date.strftime("%a, %B #{day_format} %Y") # => "Mon March 20th 2007"
}
