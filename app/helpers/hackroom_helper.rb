module HackroomHelper
  def primary_count(hackrooms)
    pluralize(hackrooms.count, 'hackroom')
  end

  def admin_count(hackroom)
    pluralize(hackroom.owners.count, 'lead')
  end

  def member_count(hackroom)
    pluralize(hackroom.all_members.count, 'member')
  end

  def language_count(hackroom)
    languages = hackroom.primary_languages.count + hackroom.languages.count
    pluralize(languages, 'language')
  end

  def admin_list_as_sentence(hackroom)
    hackroom.owners.map { |admin| (link_to admin.first_name, admin) }.to_sentence.html_safe
  end
end
