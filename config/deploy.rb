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

#load 'deploy/assets'

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

before 'deploy:finalize_update', 'deploy:assets:symlink'
after 'deploy:update_code', 'deploy:assets:precompile'

namespace :deploy do
  namespace :assets do

    task :precompile, :roles => :web do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0
        run_locally("rake assets:clean && rake assets:precompile")
        run_locally "cd public && tar -jcf assets.tar.bz2 assets"
        top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
        run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
        run_locally "rm public/assets.tar.bz2"
        run_locally("rake assets:clean")
      else
        logger.info "Skipping asset precompilation because there were no asset changes"
      end
    end

    task :symlink, :roles => :web do
      run("rm -rf #{latest_release}/public/assets &&
            mkdir -p #{latest_release}/public &&
            mkdir -p #{shared_path}/assets &&
            ln -s #{shared_path}/assets #{latest_release}/public/assets")
    end
  end
end

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