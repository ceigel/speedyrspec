require 'aws-sdk-resources'

class JsonFileWriter
  def write(json)
    File.write(SpeedyRspec.output[:name], json)
  end
end

class JsonS3Writer
  def initialize
    fail 'Please setup AWS login environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY' \
      unless ENV.key?('AWS_SECRET_ACCESS_KEY') && ENV.key?('AWS_SECRET_ACCESS_KEY')

    @s3 = Aws::S3::Resource.new(region: 'eu-west-1')
  end

  def write(json)
    bucket = @s3.bucket(SpeedyRspec.output[:bucket] || 'speedyrspec')
    object = bucket.object(SpeedyRspec.output[:name] || SpeedyRspec.trace_file)
    object.put(body: json)
  end
end

