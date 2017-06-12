class SetSlugAndUsernameForUsers < ActiveRecord::Migration[4.2]
  def change # rubocop:disable Metrics/MethodLength
    User.all.each do |user|
      if user.slug.nil? || user.slug == ''
        unless user.github.nil?
          user.username = user.github
          user.slug = user.github
          user.save
        end

        if user.slug.nil? || user.slug == ''
          user.slug = user.name.downcase.tr(" ", "-")
          user.save
        end
      end
      user.slug = user.slug.downcase
      user.save
    end
  end
end
