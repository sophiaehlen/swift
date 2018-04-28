# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html

actions :install

default_action :install

property :url, String
property :version, String, name_property: true

action :install do
  remote_file "/tmp/swift-#{version}-RELEASE-ubuntu16.04.tar.gz" do
    source url
    notifies :run, 'execute[verify_gpg]', :immediately
  end

  execute
end
