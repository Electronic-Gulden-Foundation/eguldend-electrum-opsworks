package "wget" do
	action :install
end

bash "Download and install Docker" do
	code <<-EOH
		wget -qO- https://get.docker.com/ | sh
	EOH
end
