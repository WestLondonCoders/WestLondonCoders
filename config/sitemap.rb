SitemapGenerator::Sitemap.default_host = 'https://www.westlondoncoders.com'

SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
SitemapGenerator::Sitemap.sitemaps_host = "#{ENV['S3_ASSET_URL']}/#{ENV['S3_BUCKET_NAME']}"

SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = "#{ENV['S3_BUCKET_NAME']}/sitemaps/"

SitemapGenerator::Sitemap.create do
  Course.published.each do |course|
    add course_path(course)
  end

  Language.all.each do |language|
    add language_path(language)
  end

  Hackroom.all.each do |hackroom|
    add hackroom_path(hackroom)
  end

  Post.all.each do |post|
    add post_path(post)
  end

  Meetup.all.each do |meetup|
    add meetup_path(meetup)
  end

  Course.published.each do |course|
    add course_path(course)
  end

  add courses_path
  add languages_path
  add hackrooms_path
  add posts_path
  add meetups_path
end
