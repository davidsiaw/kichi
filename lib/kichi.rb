require "kichi/version"

module Kichi
	class Kichi
		def initialize(settings)
			@settings = settings
			@s3 = Aws::S3::Client.new
		end

		def s3
			@s3
		end

		def is_valid_env_name?(env_name)
			/[a-z0-9\-_]+/.match(env_name) != nil
		end

		def is_valid_var_name?(var_name)
			/[A-Z][A-Z0-9_]+/.match(var_name) != nil
		end

		def set_var(var_name, var_content)
			if !is_valid_var_name?(var_name)
				throw "Variable name must contain only capital letters, numbers and underscores"
			end
			s3.put_object(bucket: @settings[:s3_bucket], key: "variables/#{var_name}", body: var_content)
		end

		def get_var(var_name)
			begin
				s3.get_object(bucket: @settings[:s3_bucket], key: "variables/#{var_name}").body.read
			rescue Aws::S3::Errors::NoSuchKey
				throw "Variable #{var_name} does not exist"
			end
		end

		def create_env(env_name)
			if !is_valid_env_name?(env_name)
				throw "Environment name must contain only letters, numbers, hypens and underscores"
			end
			begin
				s3.head_object(bucket: @settings[:s3_bucket], key: "environments/#{env_name}")
				throw "Environment #{env_name} already exists"
			rescue Aws::S3::Errors::NotFound
				s3.put_object(bucket: @settings[:s3_bucket], key: "environments/#{env_name}", body: {}.to_yaml)
			end
		end

		def get_env(env_name)
			begin
				YAML.load(s3.get_object(bucket: @settings[:s3_bucket], key: "environments/#{env_name}").body.read)
			rescue Aws::S3::Errors::NoSuchKey
				throw "Environment #{env_name} does not exist"
			end
		end

		def add_to_env(env_name, var_name, alias_name=nil, is_file=false)
			env = get_env(env_name)

			if is_file
				download(var_name)
				env[var_name] = {alias: alias_name, type: :file}
			else
				get_var(var_name)
				env[var_name] = {alias: alias_name, type: :envvar}
			end

			s3.put_object(bucket: @settings[:s3_bucket], key: "environments/#{env_name}", body: env.to_yaml)
		end

		def remove_from_env(env_name, var_name)
			env = get_env(env_name)
			if env[var_name]
				env.delete(var_name)
				s3.put_object(bucket: @settings[:s3_bucket], key: "environments/#{env_name}", body: env.to_yaml)
			end
		end

		def upload(var_name, filename)
			if !File.exists? filename
				throw "File #{filename} does not exist"
			end
			if !is_valid_var_name?(var_name)
				throw "Variable name must contain only capital letters, numbers and underscores"
			end
			s3.put_object(bucket: @settings[:s3_bucket], key: "files/#{var_name}", body: File.read(filename))
		end

		def download(var_name)
			begin
				s3.get_object(bucket: @settings[:s3_bucket], key: "files/#{var_name}").body.read
			rescue Aws::S3::Errors::NoSuchKey
				throw "File #{var_name} does not exist"
			end
		end
	end
end
