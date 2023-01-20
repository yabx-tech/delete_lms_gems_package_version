require './github_client'

puts "Action Started.. 🐎"

require_relative "#{ENV['GITHUB_WORKSPACE']}/#{ENV['INPUT_PACKAGE-NAME']}/lib/#{ENV['INPUT_PACKAGE-NAME']}/version"

deleting_package_version_name = Kernel.const_get("#{ENV['INPUT_PACKAGE-NAME']}".capitalize)::VERSION

puts "🎡 Environments  from yml #{ENV['INPUT_PACKAGE-NAME']}"
puts "🛣 Workspace path #{ENV['GITHUB_WORKSPACE']}"
puts "👑 Workspace all directories #{Dir['*']}"
puts "🎯 Current working directory #{Dir.pwd}"

github_client = GithubClient.new(bearer_token: ENV['GITHUB_TOKEN'], package_version_name: deleting_package_version_name)
ap github_client.delete_latest_package_version

puts "Action Completed! ✅"
