module PDF
  class S3Interactor
    def self.upload_file(file, session="base_data")
      # purely uploads a file and stores it in S3
      s3 = Aws::S3::Client.new
      s3.put_object(
        bucket: ENV['POPTART_TO_PRINT_BUCKET_NAME'],
        key: file.original_filename,
        body: file.tempfile
      )
    end
  end
end
