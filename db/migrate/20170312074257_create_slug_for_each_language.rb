class CreateSlugForEachLanguage < ActiveRecord::Migration[4.2]
  def change
    Language.all.each do |lang|
      slug = lang.name.downcase.strip.tr(" ", "-").tr('/', '-')
      lang.slug = slug
      lang.save
    end
  end
end
