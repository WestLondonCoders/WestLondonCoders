class UpdateSponsorSlugs < ActiveRecord::Migration
  def change
    Sponsor.all.each do |s|
      s.slug = s.name.strip.downcase.tr(" ", "-")
      s.save
    end
  end
end
