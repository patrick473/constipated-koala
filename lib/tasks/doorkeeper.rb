namespace :doorkeeper do

  desc 'Create a new oauth application, using a name, redirect url and a list of scopes seperated with a space.'
  task :create, [:name, :redirect_uri, :scopes] => :environment do |t, args|
    app = Doorkeeper::Application.new args
    if app.save
      puts 'application id'
      puts app.uid
      puts ''
      puts 'application secret'
      puts app.secret
      puts ''
      puts 'scopes'
      puts app.scopes

    else
      puts "failed creating #{ args[:name] }"
    end
  end

  desc 'Delete an application using the application id.'
  task :delete, [:application] => :environment do |t, args|
    app = Doorkeeper::Application.find_by_uid! args[:application]
    app.destroy
  end
end
