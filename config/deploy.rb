# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "alb-backed"
set :repo_url, "git@github.com:nov/alb-backed.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "~/alb-backed"
set :user, 'ubuntu'

set :rbenv_ruby, '2.5.1'

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :pty, true

set :keep_releases, 15

set :puma_init_active_record, true
set :puma_workers, 2
set :puma_threads, [3, 8]

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'db_seed # NOTE: DO NOT RUN THIS ON PRODUCTION'
  task :db_seed do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :finishing, :compile_assets
  after :finishing, :cleanup
  after :finishing, :restart
end
