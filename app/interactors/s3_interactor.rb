class S3Interactor
  TO_PRINT = ENV['POPTART_TO_PRINT_BUCKET_NAME']
  PRINTED  = ENV['POPTART_PRINTED_BUCKET_NAME']

  def self.upload_file_to_print(file_name, file_path, bucket_name=TO_PRINT)
    # purely uploads a file and stores it in S3
    s3 = Aws::S3::Client.new

    file = s3.put_object(
      bucket: bucket_name,
      key: file_name, # example file_name = "aditya_justworks_20190628.pdf"
      body: file_path # example file_path = "#{Rails.root}/tmp/generated_pdfs/#{file_name}"
    )

    file
  end

  # All PDFS must be saved in `#{Rails.root}/tmp/generated_pdfs/` path
  def self.upload_pdf_to_print(file_name="test_receipt.pdf", bucket_name=TO_PRINT)
    s3 = Aws::S3::Resource.new
    key = file_name
    s3_obj = s3.bucket(bucket_name).object(key)

    File.open("#{Rails.root}/tmp/generated_pdfs/#{file_name}", 'rb') do |file|
      s3_obj.put(body: file)
    end
  end

  def self.get_object_to_print(file_name, file_path, bucket_name=TO_PRINT)
    s3 = Aws::S3::Client.new

    object = s3.get_object(
      bucket: bucket_name,
      key: file_name
    )

    object
  end

  # file_name should include
  def self.save_s3_object_to_disk(object)
    object.download_file("~/Downloads/testing")
  end

  def self.save_pdf_to_disk(file_name="test_receipt.pdf", bucket_name=TO_PRINT)
    s3 = Aws::S3::Resource.new
    key = file_name
    s3.bucket(bucket_name)
      .object(key)
      .get(response_target: "./#{file_name}")
  end
end
