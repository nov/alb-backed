server 'ec2', user: 'ubuntu', roles: %w{app db web}
set :nginx_server_name, 'alb-backed.self-issued.app'
