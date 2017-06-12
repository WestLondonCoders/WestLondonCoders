class UpdateSponsorSlugs < ActiveRecord::Migration[4.2]
  def change
    Sponsor.all.each do |s|
      s.slug = s.name.strip.downcase.tr(" ", "-")
      s.save
    end
  end
end
