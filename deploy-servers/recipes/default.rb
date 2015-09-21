package 'git' do
	action :install
end

directory "/root/build" do
	action :create
end

# Clone repositories
git '/root/build/eguldend-docker' do
	repository 'https://github.com/Electronic-Gulden-Foundation/eguldend-docker.git'
end
git '/root/build/egulden-electrum-docker' do
	repository 'https://github.com/Electronic-Gulden-Foundation/egulden-electrum-docker.git'
end

# Create environment
template "/root/build/eguldend-docker/.env" do
	source "eguldend.env.erb"
end
template "/root/build/egulden-electrum-docker/.env" do
	source "egulden-electrum.env.erb"
end

bash "Install and run eguldend-docker" do
	cwd "/root/build/eguldend-docker"
	code <<-EOH
		./bin/install.sh D
		./bin/start.sh serve
	EOH
end

bash "Install and run egulden-electrum-docker" do
	cwd "/root/build/egulden-electrum-docker"
	code <<-EOH
		./bin/install.sh D
		./bin/start.sh
	EOH
end
