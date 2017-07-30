module LanguageHelper
  def language_fans(language)
    total = language.users.count + language.primary_users.count
    pluralize(total, 'like')
  end
end
