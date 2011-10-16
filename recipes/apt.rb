include_recipe "apt"

[ "curl" ].each do |pkg|
  package pkg do
    action :install
  end
end

apt_repository "node.js" do
  uri "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
  distribution node['lsb']['codename']
  components ['main']
  keyserver "keyserver.ubuntu.com"
  key "C7917B12"
  action :add
end

package "nodejs"

bash "install_npm" do
  user "root"
  cwd "/tmp/"
  code <<-EOH
    curl http://npmjs.org/install.sh | clean=no sh
  EOH
  not_if { File.exists?("/usr/bin/npm") }
end
