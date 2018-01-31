require 'net/http'
require 'json'

SCHEDULER.every '60s', first_in: 0 do |job|
  #http = Net::HTTP.new('status.github.com/api/status.json')

  uri = URI('https://status.github.com/api/status.json')

  Net::HTTP.start(uri.host, uri.port,
    :use_ssl => uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new uri

    response = http.request request # Net::HTTPResponse object
  end

  # response = http.request(Net::HTTP::Get.new("/api/status.json"))
  json = JSON.parse(response)

  if json.count <= 0
    send_event('status', statusText: "failed")
  else
    send_event('status', statusText: "#{json.status}")
  end
end

# docker run \
#     -v=/Users/kingscooty/downloads/dashing/dashboards:/dashboards \
#     -v=/Users/kingscooty/downloads/dashing/widgets:/widgets \
#     -v=/Users/kingscooty/downloads/dashing/jobs:/jobs \
#     -d -p 8080:3030 kingscooty/smashing
