require 'net/http'
require 'net/https'
require 'json'
require 'uri'

SCHEDULER.every '60s', first_in: 0 do |job|

  puts '*** Running job ***'

  # http = Net::HTTP.new('nginx-proxy1.dev.web.eu-west-1.traveljigsaw.net')
  # response = http.request(Net::HTTP::Get.new("/health/aggregator"))

  uri = URI.parse('https://status.github.com/api/status.json')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)

  json = JSON.parse(response.body)

  puts '*** JSON RESPONSE: ***'
  puts json
  puts '*** ****'

  if json.count <= 0
    send_event('health', statustext: "failed")
  else
    send_event('health', statustext: "#{json['status']}")
  end
end
