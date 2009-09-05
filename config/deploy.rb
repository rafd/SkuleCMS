default_run_options[:pty] = true

set :application, "SkuleClubs"
set :repository,  "git@rafd.xen.prgmr.com:skuleclubs.git"

set :scm, "git"
set :branch, "master"
set :scm_passphrase, "givememygit" 

set :use_sudo, false

set :deploy_via, :remote_cache

set :git_enable_submodules, 1
set :user, 'skule'
set :ssh_options, { :forward_agent => true }

role :app, "rafd.xen.prgmr.com"
role :web, "rafd.xen.prgmr.com"
role :db, "rafd.xen.prgmr.com", :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end
# If you have previously been relying upon the code to start, stop 
# and restart your mongrel application, or if you rely on the database
# migration code, please uncomment the lines you require below

# If you are deploying a rails app you probably need these:

# load 'ext/rails-database-migrations.rb'
# load 'ext/rails-shared-directories.rb'

# There are also new utility libaries shipped with the core these 
# include the following, please see individual files for more
# documentation, or run `cap -vT` with the following lines commented
# out to see what they make available.

# load 'ext/spinner.rb'              # Designed for use with script/spin
# load 'ext/passenger-mod-rails.rb'  # Restart task for use with mod_rails
# load 'ext/web-disable-enable.rb'   # Gives you web:disable and web:enable

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
 set :deploy_to, "/home/skule/domains/redux.skule.ca/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
# see a full list by running "gem contents capistrano | grep 'scm/'"

role :web, "redux.skule.ca"
