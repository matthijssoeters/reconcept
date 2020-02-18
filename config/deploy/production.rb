# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

set :user,                    'pi'
set :stage,                   :production
set :rails_env,               'production'
set :rack_env,                'production'


# Puma config
set :puma_rackup,             -> { File.join(current_path, 'config.ru') }
set :puma_state,              "unix://#{shared_path}/tmp/pids/puma.state"
set :puma_pid,                "unix://#{shared_path}/tmp/pids/puma.pid"
set :puma_bind,               "unix://#{shared_path}/tmp/sockets/puma.sock"    # accept array for multi-bind
set :puma_conf,               "#{shared_path}/puma.rb"
set :puma_access_log,         "#{shared_path}/log/puma_access.log"
set :puma_error_log,          "#{shared_path}/log/puma_error.log"
set :puma_role,               :app
set :puma_env,                'production'
set :puma_threads,            [4, 8]
set :puma_workers,            4
set :puma_worker_timeout,     nil
set :puma_init_active_record, true
set :puma_preload_app,        true
set :puma_prune_bundler,      true

set :linked_files, %w(config/database.yml config/master.key)
set :linked_dirs, %w(log tmp/cache)
# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
set :ssh_options,             forward_agent: true, user: fetch(:user), keys: ['~/.ssh/id_rsa.pub']

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

namespace :bundle do
  desc 'Install gems'
  task :bundle_install do
    on roles(:all) do
      within release_path do
        execute :bundle, 'install'
      end
    end
  end
end

# The server-based syntax can be used to override options:
# ------------------------------------
server "192.168.0.120",  
  user: "pi",
  roles: %w{web app db},
  ssh_options: {
    # user: "user_name", # overrides user setting above
    keys: %w(/home/matthijs/.ssh/id_rsa),
    forward_agent: false,
    auth_methods: %w(publickey password)
    # password: "please use keys"
  }
