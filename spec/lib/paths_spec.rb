require 'spec_helper'

describe S3Website::FileyDataSources::LocalResources do
  it 'recognises Jekyll and Nanoc site paths' do
    S3Website::Paths.site_paths.should eq(['public/output', '_site'])
  end
end
