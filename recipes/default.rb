#
# Cookbook:: swift
# Recipe:: default
#
# Copyright:: 2018, Sophia Ehlen, Apache-2.0.

version = node['swift']['version']

execute 'apt-get update'

package 'clang'
package 'libicu-dev'

swift version do
  action :install
  source "https://swift.org/builds/swift-4.1-release/ubuntu1604/swift-4.1-RELEASE/swift-4.1-RELEASE-ubuntu16.04.tar.gz"
end
