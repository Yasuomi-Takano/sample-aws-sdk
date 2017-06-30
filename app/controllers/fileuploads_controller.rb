class FileuploadsController < ApplicationController
  require 'zip'
  require 'fileutils'

  def index
  end

  def create

    uploaded_file = fileupload_param[:file]
    output_dir = Rails.root.join('public', 'zip_files')
    output_path = Rails.root.join('public', 'zip_files', uploaded_file.original_filename)
    output_extract_path = Rails.root.join('public', 'zip_files_extract')
    File.open(output_path, 'w+b') do |fp|
      fp.write  uploaded_file.read
    end

    files = uncompress(output_path, output_extract_path)
    s3_up = S3SampleUploader.new
    files.reject {|file| s3_up.file_upload(file, (output_extract_path + file)) }
    FileUtils.rm(output_path)
    FileUtils.rm_rf(output_extract_path + File.basename(uploaded_file.original_filename, '.*'))

    redirect_to action: 'index'
  end

  def new
  end

  def fileupload_param
    params.require(:fileupload).permit(:file)
  end

  def uncompress(path, outpath)
    files = []
    Zip::File.open(path) do |zip|
      zip.each do |entry|
        unless entry.name =~ /__MACOSX/ or entry.name =~ /\.DS_Store/
          files.push(entry.name)
          zip.extract(entry, outpath + entry.name) { true }
        end
      end
    end
    files
  end
end
