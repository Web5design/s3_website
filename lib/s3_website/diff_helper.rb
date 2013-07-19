module S3Website
  class DiffHelper
    def self.resolve_files_to_upload(s3_bucket, site_dir, config)
      s3_data_source = Filey::DataSources::AwsSdkS3.new(s3_bucket)
      local_resources_ds = S3Website::FileyDataSources::LocalResources.new(
        site_dir,
        config
      )
      changed_local_files =
        Filey::Comparison.list_changed(local_resources_ds, s3_data_source)
      new_local_files =
        Filey::Comparison.list_missing(local_resources_ds, s3_data_source)
      [ normalise(changed_local_files), normalise(new_local_files) ]
    end

    private

    def self.normalise(fileys)
      fileys.map { |filey|
        filey.full_path.sub(/\.\//, '')
      }
    end
  end
end
