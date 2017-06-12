class ConvertExistingEventSlugs < ActiveRecord::Migration[4.2]
  def change
    Event.all.each do |event|
      slug_date = event.date.to_date.to_s.strip.downcase.tr(" ", "-").tr(",", "")
      slug_name = event.name.strip.downcase.tr(" ", "-").tr(",", "")
      event.slug = "#{slug_date}-#{slug_name}"
      event.save
    end
  end
end
