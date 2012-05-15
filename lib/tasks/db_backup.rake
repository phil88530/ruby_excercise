#ask message for user enter input
def ask(message)
  print message
  STDIN.gets.chomp
end

namespace :db do
  desc "Backup the production database"
  task :backup => :environment do
    #get enviroment from command(RAILS_ENV=), else ask for it
    #It will system failure if RAILS_ENV is not matching to the system, by system default.
    #Because RAILS_ENV is a key word
    environment =  ENV['RAILS_ENV'] ? ENV['RAILS_ENV'] : ask("Enter the envrionment database you want to backup:\n ") 

    backup_dir = ENV['DIR'] || File.join(Rails.root, 'db','backup')

    source = File.join(Rails.root, 'db', "#{environment}.sqlite3")
    puts source

    if File.exist?(source)
      dest = File.join(backup_dir, "#{environment}.backup")
      makedirs backup_dir
      sh "sqlite3 #{source} .dump > #{dest}"
    else
      puts "Backup failed, the database does not exist !"
    end

  end
end
