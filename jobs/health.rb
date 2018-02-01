require 'net/http'
require 'json'

SCHEDULER.every '60s', first_in: 0 do |job|
  http = Net::HTTP.new('nginx-proxy1.dev.web.eu-west-1.traveljigsaw.net')
  response = http.request(Net::HTTP::Get.new("/health/aggregator"))
  json = JSON.parse(response.body)

  if json.count <= 0
    send_event('Health', statusText: "failed")
  else
    send_event('Health', statusText: "#{json['status']}")
  end
end
