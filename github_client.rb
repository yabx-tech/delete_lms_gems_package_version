require 'awesome_print'
require 'net/http'
require 'uri'
require 'json'

class GithubClient
  attr_accessor :bearer_token, :package_version_name, :deletable_version_details

  ACCEPT = 'application/vnd.github+json'
  API_VERSION = '2022-11-28'

  def initialize(**args)
    @bearer_token = "Bearer #{args[:bearer_token]}"
    @deleting_version_name = args[:package_version_name]
    @deletable_version_details = nil
  end

  def find_package_latest_version_details
    package_all_versions_url = "#{ENV['GITHUB_API_URL']}/orgs/#{ENV['INPUT_ORGANISATION-NAME']}/packages/rubygems/#{ENV['INPUT_PACKAGE-NAME']}/versions"
    all_versions = talk_to_brain(package_all_versions_url, Net::HTTP::Get)
    puts "****** 🌟 All available versions 💫 ******"
    ap all_versions
    all_versions.find { |_| _['name'] == @deleting_version_name }
  end

  def delete_latest_package_version
    puts "Version to be deleted  #{@deleting_version_name}... 🚀"
    deletable_version_details = find_package_latest_version_details
    if !deletable_version_details.nil?
      puts "****** 🏹 Selected deletable version 💣 ******"
      ap deletable_version_details
      deleted_version_response = talk_to_brain(deletable_version_details['url'], Net::HTTP::Delete)
      puts "Latest #{@deleting_version_name} version deleted successfully..💥 🔥"
      deleted_version_response
    else
      puts "Latest version not found 🚫"
    end
  end

  private

  def talk_to_brain(url, method)
    uri = URI(url)
    net_http = Net::HTTP.new(uri.host, uri.port)
    net_http.use_ssl = uri.scheme == "https"
    request = method.new(url)
    attach_details_params(request)
    response = net_http.request(request)
    JSON.parse response.body
  end

  def attach_details_params(request)
    request["Accept"] = ACCEPT
    request["Authorization"] = bearer_token
    request["X-GitHub-Api-Version"] = API_VERSION
    request
  end
end
