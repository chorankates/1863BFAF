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
    @server = 'http://1863BFAF.pwnz.org:4567'
    @meta_url = sprintf('%s/meta', @server)

    begin
      raw   = get(@meta_url)
      @urls = JSON.parse(raw.body)
    rescue => e
      fail(sprintf('server not running; try rake server, exception[%s]', e.message)) if @urls.nil? or @urls.empty?
    end

  end
  
  def test_all_the_things

    failures = Array.new

    @urls.each do |url|
      begin
        response = get(url)
        assert_not_nil(response)
        assert_equal('200', response.code)
      rescue => e
        # TODO this is showing up as an error, not a failure..
        failures << sprintf('caught an exception[%s] calling [%s]', e.message, url)
        #fail(sprintf('caught an exception[%s] calling [%s]', e.message, url))
      end
    end

    fail(sprintf('failed[%s] tests [%s]', failures.size, failures.join("\n"))) unless failures.empty?

  end

end