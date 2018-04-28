# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html

# https://swift.org/download/#using-downloads

actions :install

default_action :install

property :source, String
property :version, String, name_property: false

action :install do
  source_url = source
  #swift_version = version
  remote_file "/tmp/swift-4.1-RELEASE-ubuntu16.04.tar.gz" do
    source source_url
    notifies :run, 'execute[import_gpg_keys]', :immediately
  end

  # we only want to do this once...
  execute 'import_gpg_keys' do
    command "$ wget -q -O - https://swift.org/keys/all-keys.asc | \
gpg --import -"
    action :nothing
    notifies :run, "execute[refresh_the_keys]", :immediately
  end

  execute 'refresh_the_keys' do
    command "gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift"
    action :nothing
    notifies :run, "execute[verify_archive]", :immediately
  end

#https://swift.org/builds/swift-4.1-release/ubuntu1604/swift-4.1-RELEASE/swift-4.1-RELEASE-ubuntu16.04.tar.gz
#https://swift.org/builds/swift-4.1-release/ubuntu1604/swift-4.1-RELEASE/swift-4.1-RELEASE-ubuntu16.04.tar.gz.sig

  execute 'verify_archive' do
    command "gpg --verify swift-4.1-RELEASE-ubuntu16.04.tar.gz.sig"
    action :nothing
    notifies :run, "execute[unzip_swift_archive]", :immediately
# what we want to see
# gpg: Good signature from "Swift Automatic Signing Key #2 <swift-infrastructure@swift.org>"

# harmless as long as keys retrieved from trusted source
#     gpg: WARNING: This key is not certified with a trusted signature!
#     gpg: There is no indication that the signature belongs to the owner.


# if we get `BAD SIGNATURE`....abandon download
  end

  # extract the archive: $ tar xzf swift-<VERSION>-<PLATFORM>.tar.gz
  # this creates a /usr directory in the location of the archive
  execute 'unzip_swift_archive' do
    command "tar xzf swift-4.1-RELEASE-ubuntu16.04.tar.gz"
    action :nothing
    # TODO: add a notify here to add to path
  end

  # add swift toolchain to path: $ export PATH=/path/to/usr/bin:"${PATH}"
end
