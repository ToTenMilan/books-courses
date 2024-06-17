require "net/http"

class BaseServiceWrapper

  def initialize(service_descriptive_name, url, net_http: :use_default)
    @service_descriptive_name = service_descriptive_name
    @url                      = url.to_s
    @config                   = ServiceWrapperConfig.for(@service_descriptive_name)
    @net_http                 = if :use_default == net_http
                                  Net::HTTP
                                else
                                  net_http
                                end
  end

  def info
    {
      url: @url
    }
  end

  def status
    simulated_behaviors ||= {}
    uri = URI(@url + "/status")
    service_status = ServiceStatus.new(
      name: @service_descriptive_name,
      emoji: emoji,
      type: :api,
      throttle: @config.throttle?,
      crash: @config.crash?,
      sleep: @config.sleep,
    )
    begin
      http_response = @net_http.get_response(
        uri,
        clean_headers,
      )
      if http_response.code == "200"
        service_status.good!(self.info)
      else
        service_status.problem!("Got response #{http_response.code} instead of 200")
      end
    rescue => ex
      service_status.problem!(ex)
    end
    service_status
  end

private

  def clean_headers(content = nil)
    {
      "Accept" => "application/json",
      "Content-Length" => content.to_s.length.to_s,
    }
  end
  def headers(content = nil)
    request_headers = clean_headers(content)
    if @config.throttle?
      request_headers["X-Throttle"] = "true"
    end
    if @config.crash?
      request_headers["X-Crash"] = "true"
    end
    if @config.sleep?
      request_headers["X-Be-Slow"] = @config.sleep.to_s
    end
    request_headers
  end

  class HTTPError < StandardError
    attr_reader :code
    def initialize(code, body)
      super("#{code}: #{body}")
      @code = code
    end
  end
  class ClientError < HTTPError
  end
  class ServerError < HTTPError
  end

  def raise_error!(http_response)
    if http_response.code[0] == "4"
      raise ClientError.new(http_response.code,http_response.body)
    elsif http_response.code[0] == "4"
      raise ServerError.new(http_response.code,http_response.body)
    else
      raise HTTPError.new(http_response.code,http_response.body)
    end
  end

  CLASSES = {
    post: Net::HTTP::Post,
    put: Net::HTTP::Put,
    delete: Net::HTTP::Delete,
  }
  def request(method,uri,body)
    body = body.to_json
    request = CLASSES.fetch(method).new(uri.path,headers(body))
    request.body = body
    @net_http.new(uri.hostname,uri.port).start { |http|
      http.request(request)
    }
  end

  def self.update_config(service_name, params)
    ServiceWrapperConfig.for(service_name).update!(params)
  end
end
