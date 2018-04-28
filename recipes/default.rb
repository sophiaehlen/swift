#
# Cookbook:: swift
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

version = node['swift']['version']

execute 'apt-get update'

package %w{clang libicu-dev libpython2.7} do
    action :install
end

swift node['swift']['version'] do
  action :install
  url "https://swift.org/builds/swift-#{version}-release/ubuntu1604/swift-#{version}-RELEASE/swift-#{version}-RELEASE-ubuntu16.04.tar.gz"
end
