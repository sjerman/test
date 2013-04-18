set :application, "testappe"
set :deploy_to, "/home/sjerman/rails"
set :repository,  "git@github.com:sjerman/test.git"
set :scm, "git"
set :deploy_via, :remote_cache
server "thejermans.com", :app, :web, :db, :primary => true
set :user, "sjerman"
set :use_sudo, false
set :branch, "master"
set :ssh_options, { :forward_agent => true }
set :default_environment, { 'PATH' => '/home/sjerman/.gems/bin:/usr/lib/ruby/gems/1.8/bin/:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games' }

require "bundler/capistrano"

load 'deploy/assets'

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end