default_run_options[:pty] = true

set :application, "SkuleClubs"

role :app, "rafd.xen.prgmr.com"
role :web, "rafd.xen.prgmr.com"
role :db, "rafd.xen.prgmr.com", :primary => true

set :user, 'skule'
set :deploy_to, "/home/skule/domains/redux.skule.ca/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

set :scm, "git"
set :repository,  "git@rafd.xen.prgmr.com:SkuleCMS.git"
set :branch, "master"
set :git_enable_submodules, 1


namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end

  desc "Sync the public/assets directory."
  task :assets do
    system "rsync -vr public/assets #{user}@#{application}:#{shared_path}/"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
