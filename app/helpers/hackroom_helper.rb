module HackroomHelper
  def primary_count(hackrooms)
    pluralize(hackrooms.count, 'hackroom')
  end

  def admin_count(hackroom)
    pluralize(hackroom.owners.count, 'admin')
  end

  def member_count(hackroom)
    pluralize(hackroom.all_members.count, 'member')
  end

  def language_count(hackroom)
    languages = hackroom.primary_languages.count + hackroom.languages.count
    pluralize(languages, 'language')
  end
end
