class S3SampleUploader
	require 'aws-sdk'

	def initialize
		Aws.config[:credentials] = Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
		Aws.config[:region] = 'ap-northeast-1'
	end

	def buckets_create
		s3 = Aws::S3::Client.new
		new_bucket = s3.create_bucket({
		  bucket: "sample-aws-sdk", 
		})
		resp = s3.list_buckets
		resp.buckets.map(&:name)
	end

	def file_upload(s3_path, upload_file_path)
		if File::ftype(upload_file_path) == "file"
			bucket_name = 'sample-aws-sdk'
			s3 = Aws::S3::Client.new
			s3.put_object(
	      :bucket => bucket_name,
	      :key    => s3_path,
	      :body   => File.open(upload_file_path)
	      )
		end
	end

end