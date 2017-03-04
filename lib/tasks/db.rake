if Rails.env.development?
  namespace :db do
    task :pull, [:app, :database_url, :local_db, :drop_db] => :environment do |t, args|
      # Get the current db config
      config = Rails.configuration.database_configuration[Rails.env]
      # Set default options
      args.with_defaults(app: 'wlcrails', database_url: 'DATABASE_URL', local_db: config['database'], drop_db: true)

      # Drop DB
      Rake::Task['db:drop'].invoke if args[:drop_db]

      # Pull from Heroku
      Bundler.with_clean_env { `heroku pg:pull #{args[:database_url]} #{args[:local_db]} -a #{args[:app]}` }
    end
  end
end
