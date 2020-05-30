# frozen_string_literal: true

namespace :db do
  desc 'Pull production db to development'
  task pull: %i[dump restore:local yarn_integrity site_settings remote_assets]

  dumpfile = 'db.dump'
  env_to_pull_from = 'production'
  host = 'postgres.allofmy.co.uk'

  desc 'Dump remote postgres database'
  task :dump do
    remote = Rails.application.config.database_configuration[env_to_pull_from]
    export_dump_file_command = "su - postgres bash -c \"PGPASSFILE=~/.pgpassfile.conf pg_dump -U postgres #{remote['database']} --host=localhost --format=tar --file=#{dumpfile}\""

    puts "Running PG_DUMP on #{env_to_pull_from}"

    system "ssh root@#{host} -t '#{export_dump_file_command}'"
    system "scp root@#{host}:/var/lib/pgsql/#{dumpfile} #{Rails.root}"
    system "ssh root@#{host} -t 'rm -f /var/lib/pgsql/#{dumpfile}'"
  end

  namespace :restore do
    dev = Rails.application.config.database_configuration['development']
    pg_restore = "PGPASSWORD=#{dev['password']} pg_restore --verbose --clean --no-acl --no-owner -h localhost -d #{dev['database']} -U #{dev['username']}"

    desc 'Remote restore'
    task :remote do
      dump_file_path = "/tmp/#{dumpfile}"
      restore_command = "#{pg_restore} #{dump_file_path}"
      system "scp #{Rails.root}/#{dumpfile} root@aleut:#{dump_file_path}"
      system "ssh root@aleut -t '#{restore_command} && rm -f #{dump_file_path}'"
      File.delete(dumpfile)
    end

    desc 'Local restore'
    task :local do
      dump_file_path = dumpfile
      restore_command = "#{pg_restore} #{dump_file_path}"
      system restore_command
      File.delete(dumpfile)
    end
  end

  desc 'Check integrity of assets before proceeding to restore database'
  task :yarn_integrity do
    return unless File.directory?('node_modules')

    integrity = `yarn check --integrity`
    `yarn install` unless integrity.include?('success')
  end

  desc 'Set database environment and update any environment based settings'
  task :site_settings do
    system("rails runner \"Optimadmin::SiteSetting.where(environment: 'development').destroy_all\"")
    system("rails runner \"Optimadmin::SiteSetting.where(environment: '#{env_to_pull_from}').update_all(environment: 'development')\"")
    system('RAILS_ENV=development bin/rails db:environment:set')
  end

  desc 'Pull remote assets if Capistrano is available'
  task :remote_assets do
    if File.exist?(Rails.root.join('Capfile')) && File.exist?(Rails.root.join('lib', 'capistrano', 'tasks', 'uploads.rake'))
      system "cap #{env_to_pull_from} uploads:download"
    else
      puts 'Add uploads.rake to pull latest uploads using Capistrano'
    end
  end
end
