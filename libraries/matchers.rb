if defined?(ChefSpec)
  def install_swift(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:swift, :install, resource_name)
  end
end
