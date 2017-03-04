if Rails.env.development?
  namespace :heroku_db do
    desc "Replaces existing local database with copy of production database"
    task :pull, [:heroku_app, :database_url, :local_db] => :environment do |t, args|
      # Get the current db config
      config = Rails.configuration.database_configuration[Rails.env]

      # Set default options
      args.with_defaults(heroku_app: 'wlcrails', database_url: 'DATABASE_URL', local_db: config['database'])

      # Drop DB
      Rake::Task['db:drop'].invoke

      # Pull from Heroku
      Bundler.with_clean_env { `heroku pg:pull #{args[:database_url]} #{args[:local_db]} -a #{args[:heroku_app]}` }

      # Restore test database
      Rake::Task['db:test:prepare'].invoke

      # Run any migrations pending
      Rake::Task['db:migrate'].invoke
    end
  end

  task get_database: 'heroku_db:pull'
end
