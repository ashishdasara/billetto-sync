require 'uri'
require 'net/http'

BASE_URL = "https://billetto.dk/api/v3/public/events"

class Billetto::DataFetcher
  attr_reader :limit

  def initialize(limit = 20)
    @limit = limit
  end

  def fetch(url = nil)
    url = URI(url || BASE_URL)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Api-Keypair"] = "#{Rails.application.credentials.billetto_api_key}:#{Rails.application.credentials.billetto_api_value}"

    if url.query
      if URI.decode_www_form(url.query).any? { |key, _| key == "limit" }
        request.uri.query = url.query
      else
        request.uri.query = "#{url.query}&#{URI.encode_www_form([["limit", limit]])}"
      end
    else
      request.uri.query = URI.encode_www_form([["limit", limit]])
    end

    begin
      response = http.request(request)
      JSON.parse(response.read_body)
    rescue StandardError => e
      Rails.logger.error("Billetto::DataFetcher failed: #{e.message}")
      nil
    end
  end
end
