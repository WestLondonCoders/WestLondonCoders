module HackroomHelper
  def primary_count(hackrooms)
    pluralize(hackrooms.count, 'primary')
  end

  def secondary_count(hackrooms)
    pluralize(hackrooms.count, 'secondary')
  end
end
