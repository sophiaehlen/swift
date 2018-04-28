# # encoding: utf-8

# Inspec test for recipe swift::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe directory('/usr') do
  it { should exist }
end
