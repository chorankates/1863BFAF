require 'test/unit'

require 'json'
require 'net/http'
require 'uri'

class TestNetHTTP < Test::Unit::TestCase

  def get(url)
    uri          = URI.parse(url)
    http         = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = false
    request      = Net::HTTP::Get.new(uri)
    http.request(request)
  end

  def setup
    @server = 'http://localhost:4567'
    @meta_url = sprintf('%s/meta', @server)

    begin
      raw      = get(@meta_url)
      @methods = JSON.parse(raw.body)
    rescue => e
      fail(sprintf('server not running; try rake server, exception[%s]', e.message)) if @methods.nil? or @methods.empty?
    end

  end

  # TODO need to not stop on first failure
  def test_all_the_things
    @methods.each do |method|
      begin
        response = get(sprintf('%s/%s', @server, method))
        assert_not_nil(response)
        assert(200, response.code)
      rescue => e
        fail(sprintf('caught an exception[%s] calling [%s]', e.message, method))
      end
    end
  end

end