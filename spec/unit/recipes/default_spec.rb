#
# Cookbook:: swift
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'swift::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      #runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner = ChefSpec::ServerRunner.new(step_into: ['swift']) do |node,server|
        node.set['swift']['version'] = version
      end
      runner.converge(described_recipe)
    end

    let(:version) { '4.1' }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the necessary packages' do
      expect(chef_run).to install_package('clang')
      expect(chef_run).to install_package('libicu-dev')
    end

    it 'installs swift' do
      expect(chef_run).to install_swift(version)
    end

    it 'pulls down remote file' do
      expect(chef_run).to create_remote_file("/tmp/swift-4.1-RELEASE-ubuntu16.04.tar.gz")
    end

    # # TODO: actually check the stdout here...
    # it 'verifies the keys' do
    #   expect(chef_run).to_not raise_error
    # end

    it 'unzips swift archive' do
      resource = chef_run.remote_file("/tmp/swift-4.1-RELEASE-ubuntu16.04.tar.gz")
      # TODO: add an expect here to check that it notifies the add to path block
    end
  end
end


  # context 'When all attributes are default, on CentOS 7.4.1708' do
  #   let(:chef_run) do
  #     # for a complete list of available platforms and versions see:
  #     # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
  #     runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
  #     runner.converge(described_recipe)
  #   end
  #
  #   it 'converges successfully' do
  #     expect { chef_run }.to_not raise_error
  #   end
  # end
#end
