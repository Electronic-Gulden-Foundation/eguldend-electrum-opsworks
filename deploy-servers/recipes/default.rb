package 'git' do
	action :install
end

git '/root/build/eguldend-docker' do
	repository 'https://github.com/Electronic-Gulden-Foundation/eguldend-docker.git'
end

git '/root/build/egulden-electrum-docker' do
	repository 'https://github.com/Electronic-Gulden-Foundation/egulden-electrum-docker.git'
end

eguldend_password = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join

template "/root/build/eguldend-docker/.env" do
	source "eguldend.env.erb"
	variables({
		:password => eguldend_password,
	})
end

template "/root/build/egulden-electrum-docker/.env" do
	source "egulden-electrum.env.erb"
	variables({
		:daemon_password => eguldend_password,
	})
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
