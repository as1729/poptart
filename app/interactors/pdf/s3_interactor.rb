module PDF
  class S3Interactor
    def self.upload_file(file_name, file_path, bucket_name=ENV['POPTART_TO_PRINT_BUCKET_NAME'])
      # purely uploads a file and stores it in S3
      s3 = Aws::S3::Client.new
      s3.put_object(
        bucket: bucket_name,
        key: file_name,
        body: file_path
      )
    end
  end
end
