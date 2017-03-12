class CreateSlugForEachLanguage < ActiveRecord::Migration
  def change
    Language.all.each do  |lang|
      slug = lang.name.downcase.strip.tr(" ", "-").tr('/', '-')
      lang.slug = slug
      lang.save
    end
  end
end
